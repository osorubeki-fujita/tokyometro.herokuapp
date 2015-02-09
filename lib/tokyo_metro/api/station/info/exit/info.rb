class TokyoMetro::Api::Station::Info::Exit::Info < TokyoMetro::Api::Station::Info::Common::Info

  def initialize( point )
    @point = point
  end

  attr_reader :point

  def self.factory_for_this_class
    factory_for_generating_exit_from_string
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_exit
  end

end