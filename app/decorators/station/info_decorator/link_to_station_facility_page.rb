class Station::InfoDecorator::LinkToStationFacilityPage < TokyoMetro::Factory::Decorate::AppSubDecorator

  def from_travel_time_info
    ::Station::InfoDecorator::LinkToStationFacilityPage::FromTravelTimeInfo.new( decorator )
  end

  def with( type_of_link_to_station )
    @settings = settings( type_of_link_to_station )

    return self
  end

  def render_ja( controller_of_linked_page , set_anchor: false )
    url = url_ja( controller_of_linked_page , set_anchor )

    h_locals = h_decorator.merge({
      url: url ,
      datum_for_tooltip: datum_for_tooltip
    })

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%a{ datum_for_tooltip , href: url }<
  = d.render_name_ja
    HAML
  end

  def render_en( controller_of_linked_page = nil )
    h.link_to( object.name_en , object.station_page_name , datum_for_tooltip )
  end

  private

  def url_ja( controller_of_linked_page , set_anchor )
    station_page_name = object.station_page_name
    railway_line = @settings.try( :railway_line_in_station_page )

    if railway_line.present?
      if set_anchor
        u.url_for( controller: controller_of_linked_page , action: :action_for_station_page , station: station_page_name , anchor: railway_line , only_path: true )
      else
        u.url_for( controller: controller_of_linked_page , action: :action_for_station_page , station: station_page_name , railway_line: railway_line , only_path: true )
      end
    else
      u.url_for( controller: controller_of_linked_page , action: :action_for_station_page , station: station_page_name , only_path: true )
    end
  end

  def settings( type_of_link_to_station )
    ::Station::InfoDecorator::LinkToStationFacilityPage::Settings.new( decorator , type_of_link_to_station )
  end

  def datum_for_tooltip
    {
      'data-station_code_images' => code.all.join( '/' ) ,
      'data-text_ja' => object.name_ja ,
      'data-text_hira' => object.name_hira ,
      'data-text_en' => object.name_en
    }
  end

end
