# @note
#   This module is included
#     to {TokyoMetro::Api::StationFacility::Info}
#     by {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.set_modules} .
module TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    convert_railway_line_names_in_platform_transfer_infos
  end

  private

  # @note
  #   This method uses the method 'replace_railway_line_info'
  #     in {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} .
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::StationFacility::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.set_modules} .
  def convert_railway_line_names_in_platform_transfer_infos
    replacing = ::TokyoMetro::Modules::Api::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.replacing_railway_lines
    ignored = nil

    @platform_infos.each do | platform_info |
      if platform_info.transfer_infos.present?
        ary = self.class.platform_transfer_list_class.new

        platform_info.transfer_infos.each do | transfer_info |
          replace_railway_line_info( replacing , ignored , ary , transfer_info , inherit_info: true )
        end

        platform_info.instance_eval do
          @transfer_infos = ary
        end

      end
    end
  end

  # @note
  #   This method is called
  #     by {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info#replace_railway_line_info} .
  def railway_line_info_after_conversion( replacing_railway_line_name , transfer_info )
    self.class.platform_transfer_info_class.new( replacing_railway_line_name , transfer_info.railway_direction , transfer_info.necessary_time )
  end

end