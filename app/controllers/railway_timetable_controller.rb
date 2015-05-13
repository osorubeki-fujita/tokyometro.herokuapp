class RailwayTimetableController < ApplicationController

  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  def index
    @title = "各線の時刻表"
    render 'railway_timetable/index'
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :railway_timetable , layout: :application )
  end

  private

  def set_railway_lines_of_railway_line_page_by_params
    @railway_lines = railway_line_by_params( branch_railway_line: :no_process , yurakucho_and_fukutoshin: true )
  end

  def base_of_railway_line_page_title
    " 列車時刻表"
  end

end
