class StationTimetableDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "各駅の時刻表"
  end

  def self.common_title_en
    "Timetable of stations"
  end

end