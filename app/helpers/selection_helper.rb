#! ruby -Ku
# -*- coding: utf-8 -*-

module SelectionHelper

  def select_line
    render inline: <<-HAML , type: :haml
%div{ class: :select_line }
  %h3<
    = "路線をえらぶ"
    HAML
  end

  def select_station_from_list
    render inline: <<-HAML , type: :haml
%div{ class: :select_station_from_list }
  %h3<
    = "駅一覧から駅をえらぶ"
    HAML
  end

  def select_station_from_railway_line
    render inline: <<-HAML , type: :haml
%div{ class: :select_station_from_railway_line }
  %h3<
    = "路線から駅をえらぶ"
    HAML
  end

end