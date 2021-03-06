class Station::TrainTime < ActiveRecord::Base
  belongs_to :station_timetable_info , class: ::Station::Timetable::Info
  belongs_to :train_timetable_info , class: ::Train::Timetable::Info
  belongs_to :train_type_info_in_this_station , class: ::Train::Type::Info

  belongs_to :station_timetable_starting_station_info , class: ::Station::Timetable::StartingStationInfo
  belongs_to :station_timetable_connection_info , class: ::Station::Timetable::ConnectionInfo

  [ :operation_day , :terminal_station_info , :train_type_info ].each do | method_base_name |
    [ method_base_name , "#{ method_base_name}_id" ].each do | method_name |
      eval <<-DEF
        def #{ method_name }
          train_timetable_info.#{ method_name }
        end
      DEF
    end
  end

  def car_composition
    train_timetable_info.car_composition
  end

  def is_last?
    is_last
  end

  [ :last? , :last_train? , :is_last_train? ].each do | method_name |
    eval <<-ALIAS
      alias :#{ method_name } :is_last?
    ALIAS
  end

  def start_at_this_station?
    is_origin
  end

  [ :starting_at_this_station? , :is_starting_at_this_station? ].each do | method_name |
    eval <<-ALIAS
      alias :#{ method_name } :start_at_this_station?
    ALIAS
  end

  def has_departing_platform_info?
    platform_number.meaningful?
  end

  def has_station_timetable_starting_station_info?
    station_timetable_starting_station_info_id.meaningful?
  end

  def has_train_timetable_arrival_info?
    train_timetable_arrival_info_id.meaningful?
  end

  def train_timetable_arrival_info_id
    train_timetable_info.arrival_info_id
  end

  def train_timetable_arrival_info
    train_timetable_info.arrival_info
  end

  def has_additional_infos?
    last_train? or start_at_this_station? or has_departing_platform_info? or has_station_timetable_starting_station_info? or has_train_timetable_arrival_info?
  end

  def hour_in_station_timetable
    if departure_time_hour.present?
      departure_time_hour
    elsif arrival_time_hour.present?
      arrival_time_hour
    else
      raise "Error"
    end
  end

  def min_in_station_timetable
    if departure_time_min.present?
      departure_time_min
    elsif arrival_time_min.present?
      arrival_time_min
    else
      raise "Error"
    end
  end

end
