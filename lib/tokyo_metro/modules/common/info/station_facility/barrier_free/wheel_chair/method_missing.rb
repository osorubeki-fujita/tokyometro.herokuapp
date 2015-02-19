module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::MethodMissing

  # もともと定義されているメソッドは wheel_chair_accessible, is_available_to_wheel_chair

  # @note wheel_chair_accessible の別名として、wheel_chair_accessible? を定義
  def wheel_chair_accessible?
    wheel_chair_accessible
  end

  # @note is_available_to_wheel_chair の別名として、available_to_wheel_chair? を定義
  def available_to_wheel_chair?
    is_available_to_wheel_chair
  end

  def method_missing( method_name , *args )
    if args.empty? and /wheel(?:_?)chair/ === method_name.to_s
      case method_name.to_s
      when /\A(?:(?:is_)?for_)?wheel(?:_)?chair(?:s)?(?:\?)?\Z/
        return wheel_chair_accessible?
      when /\A(?:is_)?wheel(?:_)?chair(?:s)?_accessible(?:\?)?\Z/
        return wheel_chair_accessible?
      when /\A(?:is_)?available_(?:to|for)_wheel(?:_)?chair(?:s)?(?:\?)?\Z/
        return available_to_wheel_chair?
      end
    end

    super
  end

end