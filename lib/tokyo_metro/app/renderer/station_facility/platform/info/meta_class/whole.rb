class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::Whole < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , platform_infos , railway_lines )
    super( request )
    @platform_infos = platform_infos
    set_railway_line( [ railway_lines ].flatten )
  end

  attr_reader :platform_infos

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::Common

  # 乗車位置情報のタブを作成
  def render_tab
    raise "Error: The method \'#{ __method__ }\' is not defined yet in this class."
  end

  def render_railway_line_text_name
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :text }<
  %div{ class: :text_ja }<
    = info.railway_line_name_ja
  %div{ class: :text_en }<
    = info.railway_line_name_en
    HAML
  end

  def render_content
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%li{ id: info.tab_name , name: info.tab_name , class: :platform_info_tab_content }
  %div{ class: info.railway_line_css_class_name }
    %div{ class: :title_of_railway_line }
      %h3{ class: :text_ja }<
        = info.railway_line_name_ja
      %h4{ class: :text_en }<
        = info.railway_line_name_en
  - info.grouped_by_railway_direction.each do | infos_of_each_direction |
    = infos_of_each_direction.render
    HAML
  end

  # @!group 方面別の情報

  def grouped_by_railway_direction
    if has_railway_direction_infos?
      @platform_infos.group_by( &:railway_direction_id ).map { | railway_direction_id , infos |
        ( self.class.upper_namespace )::EachDirection.new( @request , infos , railway_line_info , ::RailwayDirection.find( railway_direction_id ) )
      }
    else
      [ ( self.class.upper_namespace )::EachDirection.new( @request , @platform_infos , railway_line_info , nil ) ]
    end
  end

  # @!endgroup

end