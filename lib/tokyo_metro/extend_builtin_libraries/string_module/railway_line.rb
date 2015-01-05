module TokyoMetro::ExtendBuiltinLibraries::StringModule::RailwayLine

  def to_railway_line_symbol
    regexp = /\Aodpt\.Railway\:TokyoMetro\.([[:alpha:]]+)\Z/
    if regexp === self
      self.gsub( regexp ) { $1 }.underscore.intern
    else
      raise "Error"
    end
  end

end