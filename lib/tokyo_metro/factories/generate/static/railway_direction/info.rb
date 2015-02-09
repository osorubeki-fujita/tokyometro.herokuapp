class TokyoMetro::Factories::Generate::Static::RailwayDirection::Info < TokyoMetro::Factories::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayDirection

  def self.hash_keys
    [ :in_api , :railway_line , :railway_direction_code , :station ]
  end

end