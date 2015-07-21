module ActionBaseForRailwayLinePage

  def action_base_for_railway_line_page( controller , layout: :application )
    set_railway_line_infos_of_railway_line_page_by_params

    if block_given?
      yield
    end

    set_title_of_railway_line_page

    render( "#{ controller }/each_railway_line" , layout: layout.to_s )
  end

  private

  def set_title_of_railway_line_page
    railway_line_infos = [ @railway_line_infos ].flatten
    class << railway_line_infos
      include ::TokyoMetro::TempLib::RailwayLineArrayModule
    end
    @title = railway_line_infos.to_railway_line_name_text_ja + base_of_railway_line_page_title
  end

end
