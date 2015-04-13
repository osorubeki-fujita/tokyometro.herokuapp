class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Toilet::Assistant < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  def self.instance_class
    barrier_free_toilet_assinstant_class
  end

  private

  def variables
    [
      # JSON
      "spac:WheelchairAssesible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
      # ドキュメント
      # "spac:WheelchairAssessible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
      # 正しい英語
      # "spac:WheelchairAccessible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
    ].map { | str |
      @array.include?( str )
    }
  end

end