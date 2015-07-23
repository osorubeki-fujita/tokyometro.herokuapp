class Station::InfoDecorator::InMatrix < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render( type_of_link_to_station , set_anchor: false )
    decorator.instance_variable_set( :@type_of_link_to_station , type_of_link_to_station )
    h.render inline: <<-HAML , type: :haml , locals: { this: self , set_anchor: set_anchor }
%li{ class: :station }<
  = this.render_link_to_station_page_ja( set_anchor: set_anchor )
    HAML
  end

end
