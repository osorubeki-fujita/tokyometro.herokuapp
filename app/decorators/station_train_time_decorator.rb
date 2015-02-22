class StationTrainTimeDecorator < Draper::Decorator
  delegate_all
  
  def departing_platform_info
    "#{ depart_from }番線発"
  end

  def render_in_station_timetable( to_stations , train_types , only_one_train_type , only_one_to_station , major_to_station_id )
    h_locals = {
      info: self ,
      to_stations: to_stations ,
      train_types: train_types.map( &:decorate ) ,
      only_one_train_type: only_one_train_type ,
      only_one_to_station: only_one_to_station ,
      major_to_station_id: major_to_station_id
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- to_station = to_stations.find { | to_station | to_station.id == info.to_station_id }
- train_type = train_types.find { | train_type | train_type.id == info.train_type_id }
- #
- departure_time_min = info.departure_time_min
- destination = to_station

- starting_station_info_id = info.station_timetable_starting_station_info_id
- train_timetable_arrival_info_id = info.train_timetable_arrival_info_id
- #
%div{ class: :train_time }
  %div{ class: :min }<
    = departure_time_min
  - unless only_one_train_type and only_one_to_station and !( info.has_additional_infos? )
    %div{ class: :precise }
      - unless only_one_train_type
        = train_type.render_in_station_timetable
      - unless only_one_to_station or ( to_station.id == major_to_station_id and !( info.last_train? ) )
        = timetable_destination_name_ja( destination )
      = info.render_additional_infos_in_station_timetable
    HAML
  end

  def render_additional_infos_in_station_timetable
    if has_additional_infos?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :additional_info }<
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
    if is_origin
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
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :starting_station }<>
  = info.station_timetable_starting_station_info.to_s
      HAML
    end
  end

  def render_arrival_info_in_station_timetable
    if has_train_timetable_arrival_info?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :arrival_info , :text_en ] }<>
  = info.train_timetable_arrival_info.platform_number_with_parentheses
      HAML
    end
  end

end