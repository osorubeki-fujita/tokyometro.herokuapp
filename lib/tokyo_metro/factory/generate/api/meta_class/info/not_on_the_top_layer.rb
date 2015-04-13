class TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  def initialize(h)
    super( h , on_the_top_layer: false )
  end

end