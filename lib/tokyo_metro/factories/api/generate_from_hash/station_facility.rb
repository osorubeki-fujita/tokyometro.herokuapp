# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ApiModules::ToFactoryClass::ConvertAndSetArrayData

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id_urn = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]

    date = DateTime.parse( @hash[ "dc:date" ] )

    [ id_urn , same_as , barrier_free_facility_list , platform_info_list , date ]
  end

  private

  # バリアフリー施設の情報の配列を作成するメソッド
  # @return [::TokyoMetro::Api::StationFacility::Info::BarrierFree::List]
  def barrier_free_facility_list
    covert_and_set_array_data( "odpt:barrierfreeFacility" ,
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::List , ::TokyoMetro::Api::StationFacility::Info::BarrierFree ,
      generate_info_instance: true )
  end

  # プラットフォームに車両が停車している時の、車両毎の最寄りの施設・出口などの情報の配列を作成するメソッド
  # @return [::TokyoMetro::Api::StationFacility::Info::Platform::List]
  def platform_info_list
    covert_and_set_array_data( "odpt:platformInformation" ,
      ::TokyoMetro::Api::StationFacility::Info::Platform::List , ::TokyoMetro::Api::StationFacility::Info::Platform::Info ,
      generate_info_instance: true )
  end

end