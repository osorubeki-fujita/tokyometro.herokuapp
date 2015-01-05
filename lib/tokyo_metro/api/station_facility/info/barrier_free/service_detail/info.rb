# 施設の詳細情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash

  # Constructor
  def initialize( service_start_time , service_end_time , operation_day )
    @service_start_time = service_start_time
    @service_end_time = service_end_time
    @operation_day = operation_day
    # 【注】エスカレーターの方向については、サブクラスのインスタンス変数として定義する。
  end

  # @return [DateTime, String or nil] 施設の利用可能開始時間（いつでも利用できる場合は省略）
  # @note 基本的にはISO8601時刻形式（05:30など）であるが、「始発」と入る場合もある。
  attr_reader :service_start_time
  # @return [DateTime, String or nil] 施設の利用可能終了時間（いつでも利用できる場合は省略）
  # @note 基本的にはISO8601時刻形式（23:50など）であるが、「終車時」と入る場合もある。
  attr_reader :service_end_time
  # @return [String] 施設利用可能時間やエスカレータの方向が曜日によって変わる場合に、次のいずれかを格納（曜日に依存しない場合は省略）
  #  Weekday, Sunday, Monday, Tuesday Wednesday Thursday Friday Saturday, Holiday
  attr_reader :operation_day

  def to_s( indent = 0 )
    " " * indent + self.operation_day_to_s + self.time_to_s
  end

  def seed( bf_instance_id )
    if @operation_day.present?
      @operation_day.split( "," ).each do | operation_day |
        seed_sub( bf_instance_id , operation_day )
      end
    else
      seed_sub( bf_instance_id )
    end
  end

  def time_to_s( indent = 0 )
    if self.time_to_a.all? { |i| i.nil? }
      "始発 - 終電"
    else
      self.time_to_a.join( " - " )
    end
  end

  def operation_day_to_s
    if self.operation_day.nil?
      "【毎日】"
    else
      " \[#{self.operation_day}\]"
    end
  end

  alias :to_strf :to_s

  def to_a
    [ @service_start_time , @service_end_time , @operation_day ]
  end

  def time_to_a
    [ @service_start_time , @service_end_time ]
  end

  def self.generate_from_hash(h)
    super( h , factory_name: :factory_of_service_detail )
  end

  private

  def seed_sub( bf_instance_id , operation_day = nil )
    if operation_day.present?
      operation_day_id = ::TokyoMetro::Seed::OperationDayProcesser.find_or_create_by_and_get_ids_of( operation_day ).first
    else
      operation_day_id = nil
    end
    pattern_id = seed_sub__get_pattern_id( bf_instance_id , operation_day_id )
    ::BarrierFreeFacilityServiceDetail.create( barrier_free_facility_id: bf_instance_id , barrier_free_facility_service_detail_pattern_id: pattern_id )
  end

  def seed_sub__get_pattern_id( bf_instance_id , operation_day_id )
    service_start_before_first_train , service_start_time_hour , service_start_time_min , service_end_time_hour , service_end_time_min , service_end_after_last_train = time_info_for_db
    escalator_direction_up , escalator_direction_down = seed__escalator_directions

    h = {
      operation_day_id: operation_day_id ,
      service_start_before_first_train: service_start_before_first_train ,
      service_start_time_hour: service_start_time_hour ,
      service_start_time_min: service_start_time_min ,
      service_end_time_hour: service_end_time_hour ,
      service_end_time_min: service_end_time_min ,
      service_end_after_last_train: service_end_after_last_train ,
      escalator_direction_up: escalator_direction_up ,
      escalator_direction_down: escalator_direction_down
    }
    pattern = ::BarrierFreeFacilityServiceDetailPattern.find_or_create_by(h)

    if pattern.nil?
      puts ::BarrierFreeFacility.find( bf_instance_id ).same_as
      puts "opration_day_id: #{operation_day_id}"
      puts "service_start_before_first_train: #{service_start_before_first_train.to_s}"
      puts "service_start_time_hour: #{service_start_time_hour.to_s} - #{service_start_time_hour.class.name}"
      puts "service_start_time_min: #{service_start_time_min.to_s} - #{service_start_time_min.class.name}"
      puts "service_end_time_hour: #{service_end_time_hour.to_s} - #{service_end_time_hour.class.name}"
      puts "service_end_time_min: #{service_end_time_min.to_s} - #{service_end_time_min.class.name}"
      puts "service_end_after_last_train: #{service_end_after_last_train.to_s}"
      puts "escalator_direction_up: #{escalator_direction_up.to_s}"
      puts "escalator_direction_down: #{escalator_direction_down.to_s}"
      raise "Error: #{ ::BarrierFreeFacility.find( bf_instance_id ).same_as }"
    end

    pattern_id = pattern.id
  end

  def time_info_for_db
    service_start_before_first_train = nil
    service_start_time_hour = nil
    service_start_time_min = nil
    service_end_time_hour = nil
    service_end_time_min = nil
    service_end_after_last_train = nil
    if @service_start_time == "始発"
      service_start_before_first_train = true
    elsif @service_start_time.present?
      service_start_time_hour , service_start_time_min = time_info_for__hour_and_min( @service_start_time )
    end
    if @service_end_time == "終車時"
      service_end_after_last_train = true
    elsif @service_end_time.present?
      service_end_time_hour , service_end_time_min = time_info_for__hour_and_min( @service_end_time )
    end
    [
      service_start_before_first_train ,
      service_start_time_hour , service_start_time_min ,
      service_end_time_hour , service_end_time_min ,
      service_end_after_last_train
    ]
  end

  def time_info_for__hour_and_min( time )
    regexp = /\A\d+\:\d+\Z/
    if time.instance_of?( ::String ) and regexp =~ time
      time.split( /\:/ ).map { |i| i.to_i }
    elsif time.instance_of?( ::Time )
      [ time.hour , time.min ]
    else
      raise "Error: #{time.inspect} (#{time.class.name})"
    end
  end

  def seed__escalator_directions
    [ nil , nil ]
  end

  # @!endgroup

end