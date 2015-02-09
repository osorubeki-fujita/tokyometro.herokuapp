module TokyoMetro::ExtendBuiltinLibraries::SymbolModule::RailwayLine::List

  def to_railway_lines_same_as
    self.map { | symbol | 
      ::TokyoMetro::ExtendBuiltinLibraries::SymbolModule.to_railway_line_same_as( symbol )
    }.flatten
  end

end