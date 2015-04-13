class TokyoMetro::Factory::Generate::Static::TrainType::InApi::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::InApi

  def self.hash_keys
    [ :name_ja , :name_ja_display , :name_en , :name_en_display ]
  end

end