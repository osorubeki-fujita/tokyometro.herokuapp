class TrainLocationController < ApplicationController

  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  def index
    @title = "現在運行中の列車"
    @railway_lines = ::RailwayLine.tokyo_metro
    render 'train_location/index'
  end
  
  def action_for_railway_line_page
    action_base_for_railway_line_page( :train_location )
  end

  private
  
  def set_railway_lines_of_railway_line_page_by_params
    @railway_lines = railway_line_by_params( branch_railway_line: :main_and_branch , yurakucho_and_fukutoshin: true )
  end
  
  def base_of_railway_line_page_title
    " 現在運行中の列車"
  end

end