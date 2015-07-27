class Station::InfoDecorator::InMatrix < TokyoMetro::Factory::Decorate::SubDecorator

  def render( type_of_link_to_station , controller_of_linked_page , set_anchor )
    d_instance = decorator.link_to_station_facility_page.with( type_of_link_to_station )

    h.render inline: <<-HAML , type: :haml , locals: { d_instance: d_instance , controller_of_linked_page: controller_of_linked_page , set_anchor: set_anchor }
%li{ class: :station }<
  = d_instance.render_ja( controller_of_linked_page , set_anchor: set_anchor )
    HAML
  end

end
