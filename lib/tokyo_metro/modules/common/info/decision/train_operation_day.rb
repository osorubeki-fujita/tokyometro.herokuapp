module TokyoMetro::Modules::Common::Info::Decision::TrainOperationDay

  # @!group 運行日に関するメソッド

  def operated_on_weekdays?
    /Weekdays\Z/ === same_as
  end

  def operated_on_saturdays_and_holidays?
    /SaturdaysHolidays\Z/ === same_as
  end

  alias :operated_on_saturdays? :operated_on_saturdays_and_holidays?
  alias :operated_on_holidays? :operated_on_saturdays_and_holidays?

  def operated_on?( operation_day )
    case operation_day
    when ::TokyoMetro::Static.operation_days.weekday.en
      operated_on_weekdays?
    when ::TokyoMetro::Static.operation_days.saturday_and_holiday.en
      operated_on_saturdays_and_holidays?
    else
      raise "Error"
    end
  end

  #-------- [alias]
  [ :weekday , :saturdays_and_holiday , :saturday , :holiday ].each do | d |
    [ :on , :is_operated_on ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ d }s? :operated_on_#{ d }s?
        alias :#{ prefix }_#{ d }? :operated_on_#{ d }s?
      ALIAS
    end
  end

  alias :is_operated_on? :operated_on?
  alias :on? :operated_on?

end