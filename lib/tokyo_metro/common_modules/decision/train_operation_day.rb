module TokyoMetro::CommonModules::Decision::TrainOperationDay

  # @!group 運行日に関するメソッド

  def is_operated_on_weekdays?
    /Weekdays\Z/ === same_as
  end

  def is_operated_on_saturdays_and_holidays?
    /SaturdaysHolidays\Z/ === same_as
  end

  alias :is_operated_on_saturdays? :is_operated_on_saturdays_and_holidays?
  alias :is_operated_on_holidays? :is_operated_on_saturdays_and_holidays?

  def is_operated_on?( operation_day )
    case operation_day
    when ::TokyoMetro::ApiModules::TimetableModules.weekday
      is_operated_on_weekdays?
    when ::TokyoMetro::ApiModules::TimetableModules.saturday_and_holiday
      is_operated_on_saturdays_and_holidays?
    else
      raise "Error"
    end
  end

  def method_missing( method_name , *variables )
    if /\A(?:is_)?(?:operated_)?(on(?:_\w+)?\?)\Z/ =~ method_name.to_s
      valid_method = "is_operated_#{$1}".intern
      if methods.include?( valid_method )
        return send( valid_method , *variables )
      end
    end
    super
  end

end