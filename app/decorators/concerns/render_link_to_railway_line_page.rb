module RenderLinkToRailwayLinePage

  def render_link_to_railway_line_page
    _url_info_in_travel_time_info_table = url_info_in_travel_time_info_table
    if _url_info_in_travel_time_info_table.present?
      h.link_to( "" ,  _url_info_in_travel_time_info_table )
    end
  end

  private

  def url_info_in_travel_time_info_table
    unless railway_line_page_exists?
      return nil
    end
    _railway_line_decorated = railway_line_decorated

    if set_anchor_in_travel_time_info_table?
      return h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name , anchor: _railway_line_decorated.travel_time_table_id )
    end

    h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name )
  end

end