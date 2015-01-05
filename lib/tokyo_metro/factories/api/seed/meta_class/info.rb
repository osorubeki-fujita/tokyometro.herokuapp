
__END__

class TokyoMetro::Factories::Api::Seed::MetaClass::Info

  def initialize( info )
    @info = info
  end

  def seed
    @infos
  end

  def self.process( info )
    self.new( info ).seed
  end

end