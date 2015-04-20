class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType < TokyoMetro::App::Renderer::MetaClass

  def initialize( request )
    super( request )
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :through_operation_info }
  - if train_type.present?
    = train_type.decorate.render_name_box_in_travel_time_info
    %div{ class: :precise }
      = this.render_precise_infos
  - else
    = this.render_precise_infos
    HAML
  end

  def render_precise_infos
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if from_station.present?
  %p{ class: :from }<
    = "〈" + from_station.name_ja + "から〉"

- if directions.present? or via.present?
  - if directions.present?
    %p{ class: :direction }<
      = directions.map( &:name_ja ).join( "、" ) + "方面"
  - if via.present?
    %p{ class: :via }<
      :ruby
        ary = [ via ].flatten.map( &:name_ja_with_operator_name_precise_and_without_parentheses )
      = ary.join( "、" ) + "経由"

%div{ class: :main }<
  - if railway_line_and_terminal_station_infos.length > 1
    - railway_line_and_terminal_station_infos.each.with_index(1) do | info , i |
      %p
        - if i == railway_line_and_terminal_station_infos.length
          = info.render( suffix: "まで直通運転" )
        - else
          = info.render( suffix: "、" )
  - else
    = railway_line_and_terminal_station_infos.first.render( suffix: "まで直通運転" )

- if note.present?
  %div{ class: :note }<
    = "（" + note.to_s + "）"
    HAML
  end

  private

  def h_locals
    super.merge({
      this: self ,
      train_type: @train_type ,
      from_station: @from_station ,
      directions: directions ,
      via: @via ,
      railway_line_and_terminal_station_infos: [ @railway_line_and_terminal_station_info ].flatten ,
      note: @note
    })
  end

  def directions
    if @direction.present?
      [ @direction ].flatten
    else
      nil
    end
  end

end