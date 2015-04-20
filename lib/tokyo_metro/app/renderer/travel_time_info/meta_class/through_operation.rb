class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request )
    @left_columns = left_columns
    @columns_next_to_railway_line = columns_next_to_railway_line
    @right_columns = right_columns
  end

  include ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Columns

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :through_operation_info_row , position ] }<

  - if left_columns > 1 and ary.present?
    %td{ class: :through_operation_infos , colspan: left_columns }<
      - if ary.length == 1
        = ary.first.render
      - else
        - ary.each do | through_operation_type |
          = through_operation_type.render

  - elsif ary.present?
    %td{ class: :through_operation_infos }<
      - if ary.length == 1
        = ary.first.render
      - else
        - ary.each do | through_operation_type |
          = through_operation_type.render

  - elsif left_columns > 1
    %td{ class: :through_operation_infos , colspan: left_columns }<
      = " "

  - if columns_next_to_railway_line == 1
    %td{ class: :through_operation_infos }<
      = " "
  - elsif columns_next_to_railway_line > 1
    %td{ class: :through_operation_infos , colspan: columns_next_to_railway_line }<
      = " "

  %td{ class: [ :railway_line_column , class_name ] }<

  - if right_columns > 1
    %td{ colspan: right_columns }<
      = " "
  - else
    %td<
      = " "
    HAML
  end

  private

  alias :__h_locals__ :h_locals

  def h_locals_base
    __h_locals__.merge({
      position: @position ,
      left_columns: @left_columns ,
      columns_next_to_railway_line: @columns_next_to_railway_line ,
      right_columns: @right_columns ,
      columns: columns
    })
  end

  def h_locals
    h_locals_base.merge({
      class_name: @class_name ,
      ary: ary
    })
  end

  def ary
    if @content.present?
      [ @content ].flatten
    else
      nil
    end
  end

end