module TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  [ :replacing_railway_lines , :ignored_railway_lines , :optional_railway_lines , :new_railway_lines , :index_in_stations , :transfer_additional_infos ].each do | filename |
    const_set(
      filename.upcase ,
      ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/additional_infos/customize/station/connecting_railway_line/#{filename}.yaml" )
    )
  end

  # Method for adding modules to classes.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info} is prepend
  #     to {TokyoMetro::Api::Station::Info} by this method.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info::ConnectingRailwayLine::Info} is prepend
  #     to {TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info} by this method.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Factory::Seed::Info::ConnectingRailwayLine::Info} is prepend
  #     to {TokyoMetro::Factory::Seed::Api::Station::Info::ConnectingRailwayLine::Info} by this method.
  def self.set_modules

    ::TokyoMetro::Api::Station::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info
    end

    ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info::ConnectingRailwayLine::Info
    end

    ::TokyoMetro::Factory::Seed::Api::Station::Info::ConnectingRailwayLine::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Factory::Seed::Info::ConnectingRailwayLine::Info
    end

  end

end