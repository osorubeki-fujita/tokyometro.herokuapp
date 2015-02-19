module StationTimetableHeaderHelper

  def timetable_header( railway_line , operation_day , direction , station , only_one_train_type , train_types , only_one_to_station , to_stations , major_to_station_id )
    h_locals = {
      railway_line: railway_line ,
      operation_day: operation_day ,
      direction: direction ,
      station: station ,
      only_one_train_type: only_one_train_type ,
      train_types: train_types ,
      only_one_to_station: only_one_to_station ,
      to_stations: to_stations ,
      major_to_station_id: major_to_station_id
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
%thead{ class: railway_line.css_class_name }
  %tr
    %td{ colspan: 2 , class: :top_header }
      = railway_line.decorate.render_in_station_timetable_header
      %div{ class: :main }
        = operation_day.decorate.render_in_station_timetable_header
        = railway_direction.decorate.render_in_station_timetable_header
        = timetable_station_name( station )
  = timetable_only_one_train_type_or_station( only_one_train_type , train_types , only_one_to_station , to_stations , major_to_station_id )
    HAML
  end

  private

  def timetable_station_name( station )
    render inline: <<-HAML , type: :haml , locals: { station: station }
%div{ class: :additional_infos }
  = display_images_of_station_codes( station , false )
  %div{ class: :station_name }<
    %div{ class: :text_ja }<
      = station_name_ja_processing_subname( station.name_ja )
    %div{ class: :text_en }<
      = station.name_en
    HAML
  end

  def timetable_only_one_train_type_or_station( only_one_train_type , train_types , only_one_to_station , to_stations , major_to_station_id )
    h_locals = {
      only_one_train_type: only_one_train_type ,
      train_types: train_types ,
      only_one_to_station: only_one_to_station ,
      to_stations: to_stations ,
      major_to_station_id: major_to_station_id
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
%tr
  %td{ colspan: 2 }<
    - str_ja = String.new
    - str_en = String.new
    - if only_one_train_type or only_one_to_station
      - str_ja = "列車はすべて"
      - str_en = "All trains are"
      - if only_one_train_type
        - str_ja += train_types.first.train_type_in_api.name_ja
        - str_en += ( " " + train_types.first.train_type_in_api.name_en )
      - if only_one_to_station
        - destination = to_stations.first
        - str_ja += ( destination.name_ja + "行き" )
        - str_en += ( " bound for " + destination.name_en )
      - str_ja += "です。"
      - str_en += "."
      - unless only_one_to_station
        - str_ja += "なお、"
        - str_en += " "
    - else
      - major_to_station = to_stations.find{ | to_station | to_station.id == major_to_station_id }
      - str_ja += "行先の記載がない列車はすべて" + major_to_station.name_ja + "行きです。"
      - str_en += "All trains with no description of destination are bound for " + major_to_station.name_en + "."
    %div{ class: :text_ja }<
      = str_ja
    %div{ class: :text_en }<
      = str_en
    HAML
  end

end