class TokyoMetro::Factory::Generate::Static::OperationDay::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Static::OperationDay

  def initialize(h)
    @h = h.with_indifferent_access
  end

  def self.hash_keys
    [ :name_ja , :name_en ]
  end

end