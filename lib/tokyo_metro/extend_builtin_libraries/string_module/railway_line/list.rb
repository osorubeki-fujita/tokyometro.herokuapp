module TokyoMetro::ExtendBuiltinLibraries::StringModule::RailwayLine::List

  def to_railway_line_symbols
    self.map { | str |
      class << str
        include ::TokyoMetro::ExtendBuiltinLibraries::StringModule::RailwayLine
      end
      str.to_railway_line_symbol
    }
  end

end