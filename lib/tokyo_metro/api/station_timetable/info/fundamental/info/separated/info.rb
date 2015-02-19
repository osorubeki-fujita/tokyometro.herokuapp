class TokyoMetro::Api::StationTimetable::Info::Fundamental::Info::Separated::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Modules::Api::Common::NotRealTime

  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  def initialize( station , railway_line , operator , railway_direction )
    @station = station
    @railway_line = railway_line
    @operator = operator
    @railway_direction = railway_direction
  end

  attr_reader :station
  attr_reader :railway_line
  attr_reader :operator
  attr_reader :railway_direction

  def self.factory_for_seeding_this_class
    factory_for_seeding_fundamental_info_separeted_info
  end

end