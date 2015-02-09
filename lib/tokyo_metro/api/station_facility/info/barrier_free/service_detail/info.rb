# 施設の詳細情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass
  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Info


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

  def all_day?
    self.time_to_a.all? { |i| i.nil? }
  end

  def everyday?
    @operation_day.nil?
  end

  def start_before_first_train?
    @service_start_time == "始発"
  end

  def end_after_last_train?
    @service_end_time == "終車時"
  end

  def operation_days
    @operation_day.split( "," )
  end

  def operation_day_to_s
    if everyday?
      "【毎日】"
    else
      " \[#{self.operation_day}\]"
    end
  end

  def time_to_s( indent = 0 )
    if all_day?
      "始発 - 終電"
    else
      self.time_to_a.join( " - " )
    end
  end

  alias :to_strf :to_s

  def to_a
    [ @service_start_time , @service_end_time , @operation_day ]
  end

  def time_to_a
    [ @service_start_time , @service_end_time ]
  end

  def time_to_h
    h = ::Hash.new

    h[ :service_start_before_first_train ] = self.start_before_first_train?
    h[ :service_start_time_hour ] = nil
    h[ :service_start_time_min ] = nil

    h[ :service_end_time_hour ] = nil
    h[ :service_end_time_min ] = nil
    h[ :service_end_after_last_train ] = self.end_after_last_train?

    if !( start_before_first_train? ) and @service_start_time.present?
      h[ :service_start_time_hour ] , h[ :service_start_time_min ] = @service_start_time.to_time_hm_array
    end

    if !( end_after_last_train? ) and @service_end_time.present?
      h[ :service_end_time_hour ] , h[ :service_end_time_min ] = @service_end_time.to_time_hm_array
    end

    h
  end

  def self.factory_for_this_class
    factory_for_generating_barrier_free_service_detail_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_service_detail_info
  end

  # @!endgroup

end