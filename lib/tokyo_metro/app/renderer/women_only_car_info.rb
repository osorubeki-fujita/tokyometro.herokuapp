class TokyoMetro::App::Renderer::WomenOnlyCarInfo < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , railway_lines )
    super( request )
    @railway_lines = railway_lines
    set_infos
  end

  def render
    if @infos.present?
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :women_only_car }
  = ::WomenOnlyCarInfoDecorator.render_sub_top_title
  - if infos.length > 1
    - infos.each do | infos_of_a_railway_line |
      = infos_of_a_railway_line.render( display_railway_line: true )
  - else
    = infos.first.render
      HAML
    end
  end

  private

  def set_infos
    @infos = ::WomenOnlyCarInfo.where( railway_line_id: @railway_lines.pluck( :id ) ).includes( :operation_day , :from_station_info , :to_station_info ).to_a.group_by( &:railway_line_id ).map { | railway_line_id , infos |
      ::TokyoMetro::App::Renderer::WomenOnlyCarInfo::EachRailwayLine.new( @request , @railway_lines.find( railway_line_id ) , infos )
    }
  end

  def h_locals
    super.merge({
      infos: @infos
    })
  end

end