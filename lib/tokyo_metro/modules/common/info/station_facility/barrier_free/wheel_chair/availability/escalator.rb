# 車いす対応エスカレーターの利用に関するメソッドを提供するモジュール
module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::Availability::Escalator

  # もともと定義されているメソッドは wheel_chair_accessible, is_available_to_wheel_chair

  # @note wheel_chair_accessible の別名として、wheel_chair_accessible? を定義
  def is_escalator_available_to_wheel_chair
    escalator? and is_available_to_wheel_chair
  end

  alias :wheel_chair_accessible_escalator :is_escalator_available_to_wheel_chair

  alias :wheel_chair_accessible_escalator? :wheel_chair_accessible_escalator
  alias :escalator_available_to_wheel_chair? :is_escalator_available_to_wheel_chair

  def method_missing( method_name , *args )
    if args.empty? and /wheel(?:_?)chair/ === method_name.to_s
      case method_name.to_s
      when /\A(?:is_)?escalator_for_wheel(?:_)?chair(?:s)?(?:\?)?\Z/
        return wheel_chair_accessible_escalator?
      when /\A(?:is_)?wheel(?:_)?chair(?:s)?_accessible_escalator(?:\?)?\Z/
        return wheel_chair_accessible_escalator?
      when /\A(?:is_)?escalator_available_(?:to|for)_wheel(?:_)?chair(?:s)?(?:\?)?\Z/
        return escalator_available_to_wheel_chair?
      end
    end

    super
  end

end