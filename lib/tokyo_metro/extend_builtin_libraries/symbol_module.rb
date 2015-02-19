module TokyoMetro::ExtendBuiltinLibraries::SymbolModule

  def self.to_railway_line_same_as( symbol )
    raise "Error" unless symbol.instance_of?( Symbol )
    ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.railway_line_string_list_in_system( symbol )
  end

end