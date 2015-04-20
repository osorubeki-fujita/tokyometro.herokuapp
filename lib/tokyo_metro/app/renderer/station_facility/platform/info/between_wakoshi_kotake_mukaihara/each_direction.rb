class TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenWakoshiAndKotakeMukaihara::EachDirection < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::EachDirection

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenWakoshiAndKotakeMukaihara::Common

  def of_special_direction?
    @railway_direction.same_as == "odpt.RailwayDirection:TokyoMetro.Namboku.AkabaneIwabuchi" or @railway_direction.same_as == "odpt.RailwayDirection:Toei.Mita.NishiTakashimadaira"
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
    "Platform for Kotake-mukaihara, Ikebukuro, Shin-kiba (Yurakucho Line) and Shibuya (Fukutoshin Line)"
  end

end