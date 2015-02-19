class RailwayDirectionDecorator < Draper::Decorator
  delegate_all
  decorates_association :station

  def render_in_station_timetable_header
    station.render_direction_in_station_timetable_header
  end

end