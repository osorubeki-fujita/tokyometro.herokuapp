class TrainLocationController < ApplicationController

  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  include TwitterProcessor
  include RealTimeInfoProcessor

  def index
    @title = "現在運行中の列車"
    @railway_line_infos = ::Railway::Line::Info.tokyo_metro
    set_twitter_processor( :tokyo_metro )
    set_real_time_info_processor

    render 'train_location/index'
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :train_location ) do
      set_twitter_processor
      set_real_time_info_processor
    end
  end

  private

  def set_railway_line_infos_of_railway_line_page_by_params
    @railway_line_infos = railway_line_by_params( branch_railway_line_info: :main_and_branch , yurakucho_and_fukutoshin: true )
  end

  def base_of_railway_line_page_title
    " 現在運行中の列車"
  end

end
