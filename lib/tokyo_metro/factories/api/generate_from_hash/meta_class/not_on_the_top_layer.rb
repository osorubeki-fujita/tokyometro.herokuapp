class TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  def initialize(h)
    super( h , on_the_top_layer: false )
  end

end