class Station::InfoDecorator::LinkToStationFacilityPage::FromTravelTimeInfo < ::TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    link_name = "#{ object.name_ja_actual }駅のご案内へジャンプします。"

    if anchor.present?
      url = h.url_for( controller: :station_facility , action: :action_for_station_page , station: object.station_page_name , anchor: anchor )
    else
      url = h.url_for( controller: :station_facility , action: :action_for_station_page , station: object.station_page_name )
    end

    h.link_to( "" , url , name: link_name )
  end

  private

  def settings( type_of_link_to_station )
    ::Station::InfoDecorator::LinkToStationFacilityPage::Settings.new( decorator , type_of_link_to_station )
  end

  def anchor
    # @settings = settings( :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf )
    @settings = settings( :must_link_to_railway_line_page_and_merge_yf )
    @settings.send( __method__ )
  end

end
