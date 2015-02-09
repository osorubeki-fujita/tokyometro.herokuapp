# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::StationFacility::Info < TokyoMetro::Factories::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Factories::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::ModuleForMethod

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id_urn = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]

    dc_date = DateTime.parse( @hash[ "dc:date" ] )

    [ id_urn , same_as , barrier_free_facility_list , platform_info_list , dc_date ]
  end

  private

  # バリアフリー施設の情報の配列を作成するメソッド
  # @return [::TokyoMetro::Api::StationFacility::Info::BarrierFree::List]
  def barrier_free_facility_list
    covert_and_set_array_data(
      "odpt:barrierfreeFacility" ,
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::List ,
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree # ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Info ではないのがポイント
    )
  end

  # プラットフォームに車両が停車している時の、車両毎の最寄りの施設・出口などの情報の配列を作成するメソッド
  # @return [::TokyoMetro::Api::StationFacility::Info::Platform::List]
  def platform_info_list
    covert_and_set_array_data(
      "odpt:platformInformation" ,
      ::TokyoMetro::Api::StationFacility::Info::Platform::List ,
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info
    )
  end

end