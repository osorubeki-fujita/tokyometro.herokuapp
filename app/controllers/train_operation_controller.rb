class TrainOperationController < ApplicationController

  include ActionBaseForStationPage
  include ActionBaseForRailwayLinePage
  include RailwayLineByParams

  include TwitterProcessor
  include RealTimeInfoProcessor

  def index
    @title = "各線の列車運行情報"
    @railway_line_infos = ::Railway::Line::Info.tokyo_metro
    @station_infos_of_railway_lines = ::Station::Info.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )

    set_twitter_processor
    set_real_time_info_processor

    render 'train_operation/index'
  end

  def action_for_station_page
    action_base_for_station_page( :train_operation ) do
      @railway_line_infos = @station_info.railway_line_infos_of_tokyo_metro
      set_twitter_processor
      set_real_time_info_processor
    end
  end

  def action_for_railway_line_page
    action_base_for_railway_line_page( :train_operation ) do
      set_twitter_processor
      set_real_time_info_processor
    end
  end

  private

  def base_of_station_page_title
    "からの列車運行情報"
  end

  def base_of_railway_line_page_title
    " 列車運行情報"
  end

  def set_railway_line_infos_of_railway_line_page_by_params
    @railway_line_infos = railway_line_by_params( branch_railway_line_info: :main_and_branch )
  end

end
