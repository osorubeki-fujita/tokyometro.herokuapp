class Railway::DirectionDecorator::InStationTimetable < TokyoMetro::Factory::Decorate::SubDecorator

  def render_in_header
    h.render inline: <<-HAML , type: :haml , locals: { station_info_decorated: object.station_info.decorate }
%div{ class: :direction }<
  = station_info_decorated.in_station_timetable.render_as_direction_info
    HAML
  end

end
