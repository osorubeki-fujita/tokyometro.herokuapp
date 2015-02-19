# @note
#   This module is included to {TokyoMetro::Api::Station::Info}
#     by {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine.set_modules} .
# @note
#   This module is included to {TokyoMetro::Api::StationFacility::Info}
#     by {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.set_modules} .
module TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info

  private

  # @note
  #   This method calls either
  #     {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info#railway_line_info_after_conversion}
  #     or {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info#railway_line_info_after_conversion} .
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info} is included
  #     to {TokyoMetro::Api::Station::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine.set_modules} .
  #
  #   This module {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::Station::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine.set_modules} .
  #
  #   So when this module 'TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info'
  #     is included to {TokyoMetro::Api::Station::Info} ,
  #     {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info#railway_line_info_after_conversion} is called.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info} is prepended
  #     to {TokyoMetro::Api::StationFacility::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.set_modules} .
  #
  #   This module {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::StationFacility::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.set_modules} .
  #
  #   So when this module 'TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info'
  #     is included to {TokyoMetro::Api::StationFacility::Info} ,
  #     {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info#railway_line_info_after_conversion} is called.
  def replace_railway_line_info( replacing , ignored , ary , info , inherit_info: false )
    if replacing.present? and replacing[ info.railway_line ].present? and replacing[ info.railway_line ][ "stations" ].include?( @same_as )

      replacing[ info.railway_line ][ "replacing_railway_line_names" ].each do | replacing_railway_line_name |
        if inherit_info
          ary << railway_line_info_after_conversion( replacing_railway_line_name , info )
        else
          ary << railway_line_info_after_conversion( replacing_railway_line_name )
        end
      end

    else
      add_connecting_railway_line_info_unless_ignore( ignored , ary , info )
    end
  end

  def add_connecting_railway_line_info_unless_ignore( ignored , ary , info )
    unless ignored.present? and ignored.find { | item | item[ "stations" ].include?( @same_as ) and item[ "railway_lines" ].include?( info.railway_line ) }.present?
      ary << info
    end
  end

end