module TokyoMetro::StaticDataModules::Hash::Seed

  def seed
    ::TokyoMetro::Seed::Inspection.title( self.class )
    time_begin = Time.now

    self.values.each do |v|
      v.seed
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin )
  end

end