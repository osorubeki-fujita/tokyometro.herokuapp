module StationTimetableHelper

  def make_station_timetables
    content = ::String.new

    class << @station_timetables
      include ForRails::StationTimetables::GroupByRailwayLine
    end

    @station_timetables.group_by_railway_line.each do | railway_line_id , station_timetables_of_a_railway_line |
      # 路線別の時刻表（複数）を取得
      railway_line = ::RailwayLine.find_by( id: railway_line_id )
      class <<station_timetables_of_a_railway_line
        include ForRails::StationTimetables::GroupByRailwayDirection
      end
      station_timetables_grouped_by_direction = station_timetables_of_a_railway_line.group_by_railway_direction
      railway_direction_ids = station_timetables_grouped_by_direction.keys.sort_by { | railway_direction_id |
        ::RailwayDirection.find_by( id: railway_direction_id ).station_info_id
      }

      railway_direction_ids.each do | railway_direction_id |
        # 方面別の時刻表（1つ）を取得
        station_timetables_of_a_direction = station_timetables_grouped_by_direction[ railway_direction_id ]
        # 【注意】station_timetables_of_a_direction は配列
        unless station_timetables_of_a_direction.length == 1
          raise "Error"
        end
        timetable_of_a_direction = station_timetables_of_a_direction.first

        # RailwayDirection のインスタンスを取得
        railway_direction = ::RailwayDirection.find_by( id: railway_direction_id )

        # 方面ごとの各列車の時刻を取得
        station_train_times_in_a_timetable_of_a_direction = timetable_of_a_direction.station_train_times.includes( :train_timetable , train_timetable: [ :terminal_station_info , :train_type , :operation_day ] )

        # 曜日ごとに仕分け
        station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days = station_train_times_in_a_timetable_of_a_direction.group_by { | train_time |
          train_time.operation_day.id
        }.sort_keys

        operation_day_ids = station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days.keys

        operation_day_ids.each do | operation_day_id |
          operation_day = ::OperationDay.find_by( id: operation_day_id )
          station_train_times_of_a_direction_and_an_operation_day = station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days[ operation_day_id ]

          content << make_station_timetable(
            station_train_times_of_a_direction_and_an_operation_day ,
            railway_line ,
            railway_direction ,
            operation_day ,
            @station_info )
        end
      end
    end
    raw content
  end

  private

  # 個別の時刻表（路線・方面・運行日別）を作成するメソッド
  # @param station_train_times_of_a_direction_and_an_operation_day [Array <TrainTime>] 各列車の情報（路線・方面・運行日別）のリスト
  # @param railway_line [RailwayLine] 路線のインスタンス
  # @param direction [RailwayDirection] 方面のインスタンス
  # @param operation_day [OperationDay] 運行日のインスタンス
  # @param station [Station] 駅のインスタンス（駅に複数の路線が乗り入れている場合は、代表する路線のインスタンス）
  def make_station_timetable( station_train_times_of_a_direction_and_an_operation_day , railway_line , direction , operation_day , station )

    # station （駅のインスタンス）に保持されている路線の情報が railway_line （路線のインスタンス）と異なる場合は、
    # railway_line を優先し、station と同名の駅に乗り入れている路線の中から railway_line と矛盾しない駅のインスタンスを取得する。
    unless station.railway_line_id == railway_line.id
      station = station.station_infos_including_other_railway_lines.find_by( railway_line_id: railway_line.id )
    end

    proc_for_getting_contents_in_train_times = Proc.new { | station_train_times , method_name |
      station_train_times.map { | station_train_time | station_train_time.send( method_name ) }.uniq
    }
    terminal_station_info_ids = proc_for_getting_contents_in_train_times.call( station_train_times_of_a_direction_and_an_operation_day , :terminal_station_info_id )
    train_type_ids = proc_for_getting_contents_in_train_times.call( station_train_times_of_a_direction_and_an_operation_day , :train_type_id )
    car_compositions = proc_for_getting_contents_in_train_times.call( station_train_times_of_a_direction_and_an_operation_day , :car_composition ).select { | car_composition | car_composition.present? }

    terminal_station_infos = ::Station::Info.find( terminal_station_info_ids )
    
    count_terminal_station_proc = ::Proc.new { | station_train_times , terminal_station_info_id |
      station_train_times.count { | station_train_time |
        station_train_time.terminal_station_info_id == terminal_station_info_id
      }
    }
    major_terminal_station_info_id = terminal_station_info_ids.max { | terminal_station_info_id_1 , terminal_station_info_id_2 |
      count_1 = count_terminal_station_proc.call( station_train_times_of_a_direction_and_an_operation_day , terminal_station_info_id_1 )
      count_2 = count_terminal_station_proc.call( station_train_times_of_a_direction_and_an_operation_day , terminal_station_info_id_2 )
      count_1 <=> count_2
    }
    train_types = ::TrainType.includes( :train_type_in_api ).find( train_type_ids )
    
    h_locals = {
      station_train_times: station_train_times_of_a_direction_and_an_operation_day ,
      railway_line: railway_line ,
      direction: direction ,
      operation_day: operation_day ,
      station: station ,
      terminal_station_infos: terminal_station_infos ,
      major_terminal_station_info_id: major_terminal_station_info_id ,
      train_types: train_types ,
      car_compositions: car_compositions
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- only_one_to_station = ( terminal_station_infos.length == 1 )
- only_one_train_type = ( train_types.map( &:train_type_in_api ).uniq.length == 1 )

- station_train_times_grouped_by_hour = station_train_times.group_by( &:departure_time_hour )
- midnight = [ 0 , 1 , 2 ]
- train_time_hours = station_train_times_grouped_by_hour.keys.sort
- midnight.each do | midnight_hour |
  - if train_time_hours.include?( midnight_hour )
    - train_time_hours = train_time_hours - [ midnight_hour ]
    - train_time_hours = train_time_hours + [ midnight_hour ]

%table{ class: [ :station_timetable , operation_day.decorate.css_class_name ] }
  = timetable_header( railway_line , operation_day , direction , station , only_one_train_type , train_types , only_one_to_station , terminal_station_infos , major_terminal_station_info_id )
  %tbody
    - train_time_hours.each do | train_time_hour |
      - station_train_times_in_an_hour = station_train_times_grouped_by_hour[ train_time_hour ].sort_by( &:departure_time_min )
      %tr{ class: :hour_row }
        %td{ class: :hour }<
          = train_time_hour
        %td{ class: [ :station_train_times , cycle( :odd , :even ) ] }
          - station_train_times_in_an_hour.each do | station_train_times |
            = station_train_times.decorate.render_in_station_timetable( terminal_station_infos , train_types , only_one_train_type , only_one_to_station , major_terminal_station_info_id )
    HAML
  end

  def timetable_header( railway_line , operation_day , railway_direction , station_info , only_one_train_type , train_types , only_one_to_station , terminal_station_infos , major_terminal_station_info_id )
    h_locals = {
      railway_line: railway_line ,
      operation_day: operation_day ,
      railway_direction: railway_direction ,
      station_info: station_info ,
      only_one_train_type: only_one_train_type ,
      train_types: train_types ,
      only_one_to_station: only_one_to_station ,
      terminal_station_infos: terminal_station_infos ,
      major_terminal_station_info_id: major_terminal_station_info_id
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
%thead{ class: railway_line.css_class_name }
  %tr
    %td{ colspan: 2 , class: :top_header }
      = railway_line.decorate.render_in_station_timetable_header
      %div{ class: :main }
        = operation_day.decorate.render_in_station_timetable_header
        = railway_direction.decorate.render_in_station_timetable_header
        - if station_info.present?
          = station_info.decorate.render_in_station_timetable_header
  = timetable_only_one_train_type_or_station( only_one_train_type , train_types , only_one_to_station , terminal_station_infos , major_terminal_station_info_id )
    HAML
  end

  def timetable_only_one_train_type_or_station( only_one_train_type , train_types , only_one_to_station , terminal_station_infos , major_terminal_station_info_id )
    h_locals = {
      only_one_train_type: only_one_train_type ,
      train_types: train_types ,
      only_one_to_station: only_one_to_station ,
      terminal_station_infos: terminal_station_infos ,
      major_terminal_station_info_id: major_terminal_station_info_id
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
        - destination = terminal_station_infos.first
        - str_ja += ( destination.name_ja + "行き" )
        - str_en += ( " bound for " + destination.name_en )
      - str_ja += "です。"
      - str_en += "."
      - unless only_one_to_station
        - str_ja += "なお、"
        - str_en += " "
    - else
      - major_to_station = terminal_station_infos.find{ | to_station | to_station.id == major_terminal_station_info_id }
      - str_ja += "行先の記載がない列車はすべて" + major_to_station.name_ja + "行きです。"
      - str_en += "All trains with no description of destination are bound for " + major_to_station.name_en + "."
    %div{ class: :text_ja }<
      = str_ja
    %div{ class: :text_en }<
      = str_en
    HAML
  end

  def timetable_destination_name_ja( destination )
    render inline: <<-HAML , type: :haml , locals: { destination: destination }
- if destination.name_ja.length <= 4
  %div{ class: :destination }<
    = destination.decorate.render_name_ja( with_subname: true )
- else
  = timetable_destination_name_ja_long( destination.name_ja.delete_station_subname )
    HAML
  end

  def timetable_destination_name_ja_long( destination_name_ja )
    splited_destination_name_ja = timetable_destination_name_ja_split_long_string( destination_name_ja )
    render inline: <<-HAML , type: :haml , locals: { splited_destination_name_ja: splited_destination_name_ja }
%div{ class: :destination }<
  - normal_size_part = splited_destination_name_ja[ :normal_size ]
  - small_size_part = splited_destination_name_ja[ :small_size ]
  - case splited_destination_name_ja.keys
  - when [ :normal_size , :small_size ]
    = normal_size_part
    - if small_size_part.present?
      %span{ class: :small }<>
        = small_size_part
  - when [ :small_size , :normal_size ]
    %span{ class: :small }<>
      = small_size_part
    = normal_size_part
  - else
    - raise "Error"
    HAML
  end

  def timetable_destination_name_ja_split_long_string( destination_name_ja )
    case destination_name_ja
    when "中野富士見町"
      { small_size: "中野" , normal_size: "富士見町" }
    when "東武動物公園"
      { normal_size: "東武" , small_size: "動物公園" }
    when "代々木上原"
      { small_size: "代々木" , normal_size: "上原" }
    when "明治神宮前"
      { normal_size: "明治" , small_size: "神宮前" }
    when "新宿三丁目"
      { normal_size: "新宿" , small_size: "三丁目" }
    when "石神井公園"
      { normal_size: "石神井" , small_size: "公園" }
    when "元町・中華街"
      { normal_size: "元町" , small_size: "・中華街" }
    else
      { normal_size: destination_name_ja , small_size: nil }
    end
  end

end