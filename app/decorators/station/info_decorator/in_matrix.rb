class Station::InfoDecorator::InMatrix < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render( type_of_link_to_station , set_anchor: false )
    d_instance = decorator.link_to_station_facility_page.with( type_of_link_to_station )

    h.render inline: <<-HAML , type: :haml , locals: { d_instance: d_instance , set_anchor: set_anchor }
%li{ class: :station }<
  = d_instance.render_ja( set_anchor: set_anchor )
    HAML
  end

end
