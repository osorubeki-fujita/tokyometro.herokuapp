class TrainLocationController < ApplicationController

  # require 'ajax_update'
  # require 'each_railway_line'
  # require 'yurakucho_and_fukutoshin_line'

  include AjaxUpdate
  include EachRailwayLine
  include YurakuchoAndFukutoshinLine

  def index
    @title = "現在運行中の列車"
    @railway_lines = ::RailwayLine.tokyo_metro
    render 'train_location/index'
  end

  private

  def each_railway_line( *railway_lines_same_as )
    each_railway_line_sub( "現在運行中の列車" , "train_location" , *railway_lines_same_as )
  end

end