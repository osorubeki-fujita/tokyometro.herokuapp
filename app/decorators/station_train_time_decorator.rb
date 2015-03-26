class StationTrainTimeDecorator < Draper::Decorator
  delegate_all
  
  def departing_platform_info
    "#{ depart_from }番線発"
  end

  def render_in_station_timetable( terminal_station_infos , train_types , only_one_train_type , only_one_to_station , major_terminal_station_info_id )
    h_locals = {
      info: self ,
      terminal_station_infos: terminal_station_infos ,
      train_types: train_types.map( &:decorate ) ,
      only_one_train_type: only_one_train_type ,
      only_one_to_station: only_one_to_station ,
      major_terminal_station_info_id: major_terminal_station_info_id
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- terminal_station_info = terminal_station_infos.find { | terminal_station_info | terminal_station_info.id == info.terminal_station_info_id }
- train_type = train_types.find { | train_type | train_type.id == info.train_type_id }
- #
- departure_time_min = info.departure_time_min
- destination = terminal_station_info

- starting_station_info_id = info.station_timetable_starting_station_info_id
- train_timetable_arrival_info_id = info.train_timetable_arrival_info_id
- #
%div{ class: :station_train_time }
  %div{ class: :min }<
    = departure_time_min
  - unless only_one_train_type and only_one_to_station and !( info.has_additional_infos? )
    %div{ class: :precise }
      - unless only_one_train_type
        = train_type.render_in_station_timetable
      - unless only_one_to_station or ( terminal_station_info.id == major_terminal_station_info_id and !( info.last_train? ) )
        = timetable_destination_name_ja( destination )
      = info.render_additional_infos_in_station_timetable
    HAML
  end

  def render_additional_infos_in_station_timetable
    if has_additional_infos?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :additional_infos }<
  = info.render_last_in_station_timetable
  = info.render_starting_info_at_this_station_in_station_timetable
  = info.render_departing_platform_info_in_station_timetable
  = info.render_starting_station_info_in_station_timetable
  = info.render_arrival_info_in_station_timetable
      HAML
    end
  end

  def render_last_in_station_timetable
    if last_train?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :last }<>
  = "最終"
      HAML
    end
  end

  def render_starting_info_at_this_station_in_station_timetable
    if start_at_this_station?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :origin }<>
  = "当駅始発"
      HAML
    end
  end

  def render_departing_platform_info_in_station_timetable
    if has_departing_platform_info?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :depart_from }<>
  = info.departing_platform_info
      HAML
    end
  end

  def render_starting_station_info_in_station_timetable
    if has_station_timetable_starting_station_info?
      station_timetable_starting_station_info.decorate.render
    end
  end

  def render_arrival_info_in_station_timetable
    if has_train_timetable_arrival_info?
      train_timetable_arrival_info.decorate.render
    end
  end

end