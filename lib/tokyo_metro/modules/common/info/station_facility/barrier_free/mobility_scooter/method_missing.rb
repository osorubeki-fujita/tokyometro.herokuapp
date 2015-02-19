module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::MobilityScooter::MethodMissing

  # もともと定義されているメソッドは mobility_scooter_accessible, is_available_to_mobility_scooter

  # @note mobility_scooter_accessible の別名として、mobility_scooter_accessible? を定義
  def mobility_scooter_accessible?
    mobility_scooter_accessible
  end

  # @note is_available_to_mobility_scooter の別名として、available_to_mobility_scooter? を定義
  def available_to_mobility_scooter?
    is_available_to_mobility_scooter
  end

  def method_missing( method_name , *args )
    if args.empty? and /mobility_scooter/ === method_name.to_s
      case method_name.to_s
      when /\A(?:(?:is_)?for_)?mobility_scooter(?:s)?(?:\?)?\Z/
        return mobility_scooter_accessible?
      when /\A(?:is_)?mobility_scooter(?:s)?_accessible(?:\?)?\Z/
        return mobility_scooter_accessible?
      when /\A(?:is_)?available_(?:to|for)_mobility_scooter(?:s)?(?:\?)?\Z/
        return available_to_mobility_scooter?
      end
    end

    super
  end

end