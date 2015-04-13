class TokyoMetro::Factory::Generate::Api::StationTimetable::Info::Fundamental::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  def variables
    stations = @hash[ "odpt:station" ]
    railway_lines = @hash[ "odpt:railway" ]
    operators = @hash[ "odpt:operator" ]
    railway_directions = @hash[ "odpt:railDirection" ]

    [ [ stations ] , [ railway_lines ] , [ operators ] , [ railway_directions ] ]
  end

  def self.instance_class
    fundamental_info_class
  end

end