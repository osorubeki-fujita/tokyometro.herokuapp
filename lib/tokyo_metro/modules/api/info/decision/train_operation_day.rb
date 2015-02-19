module TokyoMetro::Modules::Api::Info::Decision::TrainOperationDay

  include ::TokyoMetro::Modules::Common::Info::Decision::TrainOperationDay

  # @!group 運行日に関するメソッド

  # 運行日のDBでのインスタンス
  # @return [::OperationDay]
  def operation_day_in_db
    if operated_on_weekdays?
      ::OperationDay.find_by_name_en( ::TokyoMetro::Static.operation_days.weekday.en )
    elsif operated_on_saturdays_and_holidays?
      ::OperationDay.find_by_name_en( ::TokyoMetro::Static.operation_days.saturday_and_holiday.en )
    else
      raise "Error"
    end
  end

  # @!endgroup

end