# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::ModuleForMethod

  def variables
    ary_1 = [ "odpt:railway" , "odpt:carComposition" , "odpt:carNumber" , "odpt:railDirection" ].map { | key | @hash[ key ] }
    ary_2 = [ transfer_info , barrier_free , surrounding_area ]

    ary_1 + ary_2
  end

  def self.instance_class
    platform_info_class
  end

  private

  def transfer_info
    covert_and_set_array_data( "odpt:transferInformation" , self.class.platform_transfer_list_class , self.class.platform_transfer_info_class )
  end

  def barrier_free
    covert_and_set_array_data( "odpt:barrierfreeFacility" , self.class.platform_barrier_free_list_class , self.class.platform_barrier_free_info_class )
  end

  def surrounding_area
    covert_and_set_array_data( "odpt:surroundingArea" , self.class.platform_surrounding_area_list_class , self.class.platform_surrounding_area_info_class )
  end

end