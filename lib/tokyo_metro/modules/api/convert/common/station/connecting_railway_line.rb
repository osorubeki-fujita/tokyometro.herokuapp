module TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine

  # Method for adding modules to classes.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info} is included
  #     to {TokyoMetro::Api::Station::Info} by this method.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info} is included
  #     to {TokyoMetro::Api::Station::Info} by this method.
  def self.set_modules

    ::TokyoMetro::Api::Station::Info.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Common::StationInfos::ConvertRailwayLineNames::Info
      include ::TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info
    end

  end

end