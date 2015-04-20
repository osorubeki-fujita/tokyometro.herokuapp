class TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::Whole < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::Whole

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::Common

  # 乗車位置情報のタブを作成
  def render_tab
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%li{ class: [ "tab_for_" + info.tab_name.to_s , :platform_info_tab ] }<
  %div{ class: :railway_line_name , onclick: raw( "changeStationFacilityPlatformInfoTabByPageLink('" + info.tab_name.to_s + "' , true ) ; return false ; " ) }
    %div{ class: info.railway_line.css_class_name }
      = info.railway_line.decorate.render_railway_line_code( small: true )
    = info.render_railway_line_text_name
    HAML
  end

  private

  def set_railway_line( railway_lines )
    raise "Error" unless railway_lines.length == 1
    @railway_line = railway_lines.first
  end

end