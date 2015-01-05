module TokyoMetro::ExtendBuiltinLibraries::SymbolModule

  def self.to_railway_line_same_as( symbol )
    raise "Error" unless symbol.instance_of?( Symbol )
    "odpt.Railway:TokyoMetro.#{ symbol.to_s.camelize }"
  end

end