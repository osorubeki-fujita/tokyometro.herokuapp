class TokyoMetro::Factory::Generate::Static::StationsInTokyoMetro::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro

  def self.hash_keys
    [
      :station_facility_custom , :station_facility_custom_alias ,
      :name_ja , :name_hira , :name_in_system , :name_en ,
      :administrator , :other_operator
    ]
  end

end