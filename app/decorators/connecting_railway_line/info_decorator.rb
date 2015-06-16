class ConnectingRailwayLine::InfoDecorator < Draper::Decorator
  delegate_all

  decorates_association :railway_line

  def url_for_railway_line_page
    unless railway_line_page_exists?
      return nil
    end

    _railway_line_decorated = railway_line_decorated

    # if set_anchor_in_travel_time_info_table?
      # return h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name , anchor: _railway_line_decorated.travel_time_table_id )
    # end

    return h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name )
  end

  private

  def railway_line_decorated
    railway_line.decorate
  end

  def railway_line_page_name
    railway_line_decorated.send( __method__ )
  end

  def railway_line_page_exists?
    object.railway_line.tokyo_metro?
  end

  def set_anchor_in_travel_time_info_table?
    # object.railway_line.branch_line? or object.station_info.railway_line.branch_railway_line_of?( object.railway_line )
    false
  end

end
