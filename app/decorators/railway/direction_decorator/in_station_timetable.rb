class Railway::DirectionDecorator::InStationTimetable < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_in_header
    h.render inline: <<-HAML , type: :haml , locals: { station_info_deccorated: object.station_info.decorate }
%div{ class: :direction }<
  = station_info_deccorated.in_station_timetable.render_as_direction_info
    HAML
  end

end
