class Station::InfoDecorator::InTravelTimeInfo < TokyoMetro::Factory::Decorate::SubDecorator

=begin

  def render_square
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
    HAML
  end

=end

  def render_name
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
= d.link_to_station_facility_page.from_travel_time_info.render
%div{ class: [ :station_info_domain , :clearfix ] }
  = d.code.render_image( all: false )
  %div{ class: :text }<
    = d.render_name_ja_and_en
    HAML
  end

  def render_connecting_railway_lines
    h_locals = {
      request: request ,
      c_railway_line_infos: object.connecting_railway_line_infos.display_on_railway_line_page.includes( :railway_line_info , railway_line_info: :operator_info )
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ class: [ :railway_lines , :clearfix ] }
  - c_railway_line_infos.each do | connecting_railway_line_info |
    = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Station::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
  end

end
