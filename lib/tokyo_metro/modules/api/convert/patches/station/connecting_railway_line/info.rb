# @note
#   This module is prepended
#     to {TokyoMetro::Api::Station::Info}
#     by {TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine::Info

  # Constructor
  # @note
  #   This method uses the method 'convert_and_delete_connecting_railway_line_names'
  #     in {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info} .
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info} is included
  #     to {TokyoMetro::Api::Station::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine.set_modules} .
  def initialize( *variables )
    super( *variables )
    convert_and_delete_connecting_railway_line_names(
      ignored: ::TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine.ignored_railway_lines
    )
  end

end