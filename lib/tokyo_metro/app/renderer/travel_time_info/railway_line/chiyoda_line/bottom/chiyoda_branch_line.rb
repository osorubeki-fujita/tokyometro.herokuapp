class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Bottom::ChiyodaBranchLine < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , branch_railway_line )
    super( request )
    @branch_railway_line = branch_railway_line

    @kita_ayase = @branch_railway_line.station_infos.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :railway_line_column , :chiyoda , :kita_ayase ] }
  %div{ class: :travel_time_info_square }<
    = " "
%td{ class: [ :station_info , :auto_width , :kita_ayase ] }
  = kita_ayase.decorate.render_name_in_travel_time_infos
    HAML
  end

  private

  def h_locals
    super.merge({
      railway_line: @branch_railway_line ,
      kita_ayase: @kita_ayase
    })
  end

end