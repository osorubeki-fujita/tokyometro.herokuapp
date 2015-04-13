class TokyoMetro::Factory::Generate::Static::TrainInformationStatus::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus

  def initialize(h)
    @h = h.with_indifferent_access
  end

  def self.hash_keys
    [ :in_api , :name_ja ]
  end

end