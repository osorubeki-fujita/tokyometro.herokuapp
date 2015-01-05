module TokyoMetro::ApiModules::Decision::TrainOperationDay

  include ::TokyoMetro::CommonModules::Decision::TrainOperationDay

  # 運行日のDBでのインスタンス
  # @return [::OperationDay]
  def operation_day_instance_in_db
    if operated_on_weekdays?
      ::OperationDay.find_by_name_en( ::TokyoMetro::ApiModules::TimetableModules.weekday )
    elsif operated_on_saturdays_and_holidays?
      ::OperationDay.find_by_name_en( ::TokyoMetro::ApiModules::TimetableModules.saturday_and_holiday )
    else
      raise "Error"
    end
  end

end