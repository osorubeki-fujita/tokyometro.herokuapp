module TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  IGNORED_RAILWAY_LINES = ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/additional_infos/patches/station/connecting_railway_line/igonored_railway_lines.yaml" )

  # Method for adding modules to classes.
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine::Info} is prepend
  #     to {TokyoMetro::Api::Station::Info} by this method.
  def self.set_modules

    ::TokyoMetro::Api::Station::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Patches::Station::ConnectingRailwayLine::Info
    end

  end

end