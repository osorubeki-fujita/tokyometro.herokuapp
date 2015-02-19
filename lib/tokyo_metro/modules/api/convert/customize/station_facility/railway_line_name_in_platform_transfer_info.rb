module TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  REPLACING_RAILWAY_LINES = ::YAML.load_file(
    "#{ ::TokyoMetro::dictionary_dir }/additional_infos/customize/station_facility/transfer_info/replacing_railway_lines.yaml"
  )

  # モジュールをクラスに追加するためのメソッド
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::StationFacility::Info} by this method.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info} is prepended
  #     to {TokyoMetro::Api::StationFacility::Info} by this method.
  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info
    end
  end

end