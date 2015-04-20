class TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenMeguroAndShirokaneTakanawa::EachDirection < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::EachDirection

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenMeguroAndShirokaneTakanawa::Common

  def of_special_direction?
    @railway_direction.railway_line.same_as == "odpt.Railway:TokyoMetro.Namboku" and @railway_direction.same_as == "odpt.RailwayDirection:TokyoMetro.Namboku.AkabaneIwabuchi"
  end

  def render_special_direction_ja
    h.render inline: <<-HAML , type: :haml
= "白金高輪・"
%span{ class: :railway_line_name }<>
  ="南北線"
= "赤羽岩淵・"
%span{ class: :railway_line_name }<>
  = "都営三田線"
= "西高島平" + "方面行きホーム"
    HAML
  end

  def special_direction_en
    "Platform for Shirokane-takanawa, Akabane-iwabuchi (Namboku Line) and Nishi-takashimadaira (Toei Mita Line)"
  end

end