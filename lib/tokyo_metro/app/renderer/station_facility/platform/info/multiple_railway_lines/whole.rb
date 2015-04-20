class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::Whole < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::Whole

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::Common

  # 乗車位置情報のタブを作成
  def render_tab
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%li{ class: [ "tab_for_" + info.tab_name , :platform_info_tab ] }<
  %div{ class: :railway_line_name , onclick: raw( "changeStationFacilityPlatformInfoTabByPageLink('" + info.tab_name.to_s + "' , true ) ; return false ; " ) }
    - info.railway_lines.each do | railway_line |
      - railway_line_decorated = railway_line.decorate
      %div{ class: railway_line_decorated.css_class_name }
        = railway_line_decorated.render_railway_line_code( small: true )
    = info.render_railway_line_text_name
    HAML
  end

end