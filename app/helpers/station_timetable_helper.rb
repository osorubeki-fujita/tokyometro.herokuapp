module StationTimetableHelper

  def title_in_station_timetable_top
    render inline: <<-HAML , type: :haml
%div{ id: :station_timetable_title }
  = common_title_of_station_timetable
  = application_common_top_title
    HAML
  end

  def title_of_station_timetable_in_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :station_timetable_title }
  = common_title_of_station_timetable
  = railway_line_name_main( railway_lines )
    HAML
  end

  def title_of_station_timetable_in_each_station
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :station_facility_title }
  = common_title_of_station_timetable
  = station_name_main( station , station_code: true , all_station_codes: true )
    HAML
  end

  def make_timetables
    timetables_grouped_by_railway_line = @timetables.group_by { | timetable | timetable.railway_line_id }

    h_locals = {
      timetables_grouped_by_railway_line: timetables_grouped_by_railway_line ,
      station: @station
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
- timetables_grouped_by_railway_line.keys.sort.each do | railway_line_id |
  - # 路線別の時刻表（複数）を取得
  - timetables_of_a_railway_line = timetables_grouped_by_railway_line[ railway_line_id ]
  - #
  - railway_line = ::RailwayLine.find_by( id: railway_line_id )
  - timetables_grouped_by_direction = timetables_of_a_railway_line.group_by { | timetable | timetable.railway_direction_id }
  - timetable_railway_direction_ids = timetables_grouped_by_direction.keys.sort_by { | direction_id | ::RailwayDirection.find_by( id: direction_id ).station_id }
  - timetable_railway_direction_ids.each do | direction_id |
    - # 方面別の時刻表（1つ）を取得
    - timetables_of_a_direction = timetables_grouped_by_direction[ direction_id ]
    - # 【注意】timetables_of_a_direction は配列
    - unless timetables_of_a_direction.length == 1
      - raise "Error"
    - timetable_of_a_direction = timetables_of_a_direction.first
    - # RailwayDirection のインスタンスを取得
    - direction = timetable_of_a_direction.railway_direction # ::RailwayDirection.find_by( id: direction_id )
    - # 方面ごとの各列車の時刻を取得
    - train_times_in_a_timetable_of_a_direction = timetable_of_a_direction.train_times.includes( :to_station , :train_type , :operation_day )
    - # 曜日ごとに仕分け
    - train_times_in_a_timetable_of_a_direction_grouped_by_operation_days = train_times_in_a_timetable_of_a_direction.group_by { | train_time | train_time.operation_day_id }
    - operation_day_ids = train_times_in_a_timetable_of_a_direction_grouped_by_operation_days.keys.sort
    - operation_day_ids.each do | operation_day_id |
      - train_times_of_a_direction_and_an_operation_day = train_times_in_a_timetable_of_a_direction_grouped_by_operation_days[ operation_day_id ]
      - operation_day = ::OperationDay.find_by( id: operation_day_id )
      = make_timetable( train_times_of_a_direction_and_an_operation_day , railway_line , direction , operation_day , station )
    HAML
  end

  private

  def common_title_of_station_timetable
    title_of_main_contents( common_station_timetable_title_ja , common_station_timetable_title_en )
  end

  def common_station_timetable_title_ja
    "各駅の時刻表"
  end

  def common_station_timetable_title_en
    "Timetable of stations"
  end

  # 個別の時刻表（路線・方面・運行日別）を作成するメソッド
  # @param train_times_of_a_direction_and_an_operation_day [Array <TrainTime>] 各列車の情報（路線・方面・運行日別）のリスト
  # @param railway_line [RailwayLine] 路線のインスタンス
  # @param direction [RailwayDirection] 方面のインスタンス
  # @param operation_day [OperationDay] 運行日のインスタンス
  # @param station [Station] 駅のインスタンス（駅に複数の路線が乗り入れている場合は、代表する路線のインスタンス）
  def make_timetable( train_times_of_a_direction_and_an_operation_day , railway_line , direction , operation_day , station )

    # station （駅のインスタンス）に保持されている路線の情報が railway_line （路線のインスタンス）と異なる場合は、
    # railway_line を優先し、station と同名の駅に乗り入れている路線の中から railway_line と矛盾しない駅のインスタンスを取得する。
    unless station.railway_line_id == railway_line.id
      station = station.station_facility.stations.find_by( railway_line_id: railway_line.id )
    end

    h_locals = {
      train_times: train_times_of_a_direction_and_an_operation_day ,
      railway_line: railway_line ,
      direction: direction ,
      operation_day: operation_day ,
      station: station ,
      proc_for_getting_contents_in_train_times: Proc.new { | train_times , method_name |
        train_times.map { | train_time | train_time.send( method_name ) }.uniq
      }
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- to_station_ids = proc_for_getting_contents_in_train_times.call( train_times , :to_station_id )
- train_type_ids = proc_for_getting_contents_in_train_times.call( train_times , :train_type_id )
- car_compositions = proc_for_getting_contents_in_train_times.call( train_times , :car_composition ).select { | car_composition | car_composition.present? }

- to_stations = ::Station.find( to_station_ids )
- train_types = ::TrainType.includes( :train_type_in_api ).find( train_type_ids )

- only_one_to_station = ( to_stations.length == 1 )
- only_one_train_type = ( train_types.map { | train_type | train_type.train_type_in_api }.uniq.length == 1 )

- count_to_station_proc = Proc.new { | to_station_id | train_times.count { | train_time | train_time.to_station_id == to_station_id } }
- major_to_station_id = to_station_ids.max { | to_station_id_1 , to_station_id_2 | count_to_station_proc.call( to_station_id_1 ) <=> count_to_station_proc.call( to_station_id_2 ) }

- train_times_grouped_by_hour = train_times.group_by { | train_time | train_time.departure_time_hour }
- midnight = [ 0 , 1 , 2 ]
- train_time_hours = train_times_grouped_by_hour.keys.sort
- midnight.each do | midnight_hour |
  - if train_time_hours.include?( midnight_hour )
    - train_time_hours = train_time_hours - [ midnight_hour ]
    - train_time_hours = train_time_hours + [ midnight_hour ]

%table{ class: [ :station_timetable , operation_day.name_en.downcase ] }
  = timetable_header( railway_line , operation_day , direction , station , only_one_train_type , train_types , only_one_to_station , to_stations , major_to_station_id )
  %tbody
    - train_time_hours.each do | train_time_hour |
      - train_times_in_an_hour = train_times_grouped_by_hour[ train_time_hour ].sort_by { | train_time | train_time.departure_time_min }
      %tr{ class: :hour_row }
        %td{ class: :hour }<
          = train_time_hour
        %td{ class: [ :train_times , cycle( :odd , :even ) ] }
          - train_times_in_an_hour.each do | train_time |
            = timetable_each_train_time( train_time , to_stations , train_types , only_one_train_type , only_one_to_station , major_to_station_id )
    HAML
  end

  def timetable_each_train_time( train_time , to_stations , train_types , only_one_train_type , only_one_to_station , major_to_station_id )
    h_locals = {
      train_time: train_time ,
      to_stations: to_stations ,
      train_types: train_types ,
      only_one_train_type: only_one_train_type ,
      only_one_to_station: only_one_to_station ,
      major_to_station_id: major_to_station_id
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
- to_station = to_stations.find { | to_station | to_station.id == train_time.to_station_id }
- train_type = train_types.find { | train_type | train_type.id == train_time.train_type_id }
- #
- departure_time_min = train_time.departure_time_min
- train_type_in_api = train_type.train_type_in_api
- destination = to_station

- is_last = train_time.is_last
- is_origin = train_time.is_origin
- depart_from = train_time.depart_from
- starting_station_info_id = train_time.station_timetable_starting_station_info_id
- train_timetable_arrival_info_id = train_time.train_timetable_arrival_info_id
- additional_info_exists = train_time.has_additional_info?
- #
%div{ class: :train_time }
  %div{ class: :min }<
    = departure_time_min
  - unless only_one_train_type and only_one_to_station and !( additional_info_exists )
    %div{ class: :precise }
      - unless only_one_train_type
        %div{ class: :train_type }<>
          = train_type_in_api.name_ja
      - unless only_one_to_station or ( to_station.id == major_to_station_id and !( is_last ) )
        = timetable_destination_name_ja( destination )
      - if additional_info_exists
        %div{ class: :additional_info }<
          - if is_last
            %div{ class: :last }<>
              = "最終"
          - if is_origin
            %div{ class: :origin }<>
              = "当駅始発"
          - if depart_from.meaningful?
            %div{ class: :depart_from }<>
              = depart_from.to_s + "番線発"
          - if starting_station_info_id.meaningful?
            %div{ class: :starting_station }<>
              = starting_station = train_time.station_timetable_starting_station_info.to_s
          - if train_timetable_arrival_info_id.meaningful?
            %div{ class: [ :arrival_info , :text_en ] }<>
              = train_time.train_timetable_arrival_info.platform_number_with_parentheses
    HAML
  end

  def timetable_destination_name_ja( destination )
    destination_name_ja = destination.name_ja.delete_station_subname
    render inline: <<-HAML , type: :haml , locals: { destination_name_ja: destination_name_ja }
- if destination_name_ja.length <= 4
  %div{ class: :destination }<
    = station_name_ja_processing_subname( destination_name_ja )
- else
  = timetable_destination_name_ja_long( destination_name_ja )
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