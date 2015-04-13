class RailwayTimetableController < ApplicationController

  # require 'each_railway_line'
  # require 'yurakucho_and_fukutoshin_line'
  include EachRailwayLine
  include YurakuchoAndFukutoshinLine

  def index
    @title = "各線の時刻表"
    render 'railway_timetable/index'
  end

  private

  def each_railway_line( *railway_lines_same_as )
    each_railway_line_sub( "列車時刻表" , "railway_timetable" , *railway_lines_same_as )
  end

end
