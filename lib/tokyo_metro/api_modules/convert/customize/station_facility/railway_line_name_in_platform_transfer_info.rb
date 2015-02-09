module TokyoMetro::ApiModules::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  REPLACING_RAILWAY_LINES = ::YAML.load_file(
    "#{ ::TokyoMetro::dictionary_dir }/additional_infos/customize/station_facility/transfer_info/replacing_railway_lines.yaml"
  )

  # モジュールをクラスに追加するためのメソッド
  # @note
  #   {TokyoMetro::ApiModules::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::StationFacility::Info} by this method.
  # @note
  #   {TokyoMetro::ApiModules::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info} is prepended
  #     to {TokyoMetro::Api::StationFacility::Info} by this method.
  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Common::StationInfos::ConvertRailwayLineNames::Info
      prepend ::TokyoMetro::ApiModules::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info
    end
  end

end