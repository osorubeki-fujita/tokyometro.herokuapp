class RailwayLineController < ApplicationController

  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  def index
    @title = "路線のご案内"
    render 'railway_line/index'
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :railway_line , layout: :application )
  end

  private

  def set_railway_lines_of_railway_line_page_by_params
    @railway_lines = railway_line_by_params( branch_railway_line: :main_and_branch , yurakucho_and_fukutoshin: true )
  end

  def base_of_railway_line_page_title
    "のご案内"
  end

end