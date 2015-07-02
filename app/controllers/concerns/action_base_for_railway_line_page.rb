module ActionBaseForRailwayLinePage

  def action_base_for_railway_line_page( controller , layout: :application )
    set_railway_lines_of_railway_line_page_by_params

    if block_given?
      yield
    end

    set_title_of_railway_line_page

    render( "#{ controller }/each_railway_line" , layout: layout.to_s )
  end
  
  private

  def set_title_of_railway_line_page
    railway_lines = [ @railway_lines ].flatten
    class << railway_lines
      include ::TokyoMetro::TempLib::RailwayLineArrayModule
    end
    @title = railway_lines.to_railway_line_name_text_ja + base_of_railway_line_page_title
  end

end