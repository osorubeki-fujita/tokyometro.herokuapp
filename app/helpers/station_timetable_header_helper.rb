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
      = timetable_railway_line_name( railway_line )
      %div{ class: :main }
        = timetable_operation_day( operation_day )
        = timetable_railway_direction( direction )
        = timetable_station_name( station )
  = timetable_only_one_train_type_or_station( only_one_train_type , train_types , only_one_to_station , to_stations , major_to_station_id )
    HAML
  end

  private

  def timetable_railway_line_name( railway_line )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = railway_line.name_ja
  %span{ class: :text_en }<
    = railway_line.name_en
    HAML
  end

  def timetable_operation_day( operation_day )
    render inline: <<-HAML , type: :haml , locals: { operation_day: operation_day }
%div{ class: :operation_day }<
  %div{ class: :text_ja }<
    = operation_day.name_ja
  %div{ class: :text_en }<
    = operation_day.name_en.pluralize
    HAML
  end

  def timetable_railway_direction( railway_direction )
    render inline: <<-HAML , type: :haml , locals: { railway_direction: railway_direction }
%div{ class: :direction }<
  %div{ class: :text_ja }<
    = railway_direction.station.name_ja + "方面"
  %div{ class: :text_en }<
    = "for " + railway_direction.station.name_en
    HAML
  end

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
    - if only_one_to_station or only_one_to_station
      - str_ja = "列車はすべて"
      - str_en = "All trains are"
      - if only_one_train_type
        - str_ja += train_types.first.train_type_in_api.name_ja
        - str_en += " "
        - str_en += train_types.first.train_type_in_api.name_en
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