class Station::InfoDecorator::AsDirectionInfo < TokyoMetro::Factory::Decorate::AppSubDecorator

  def name_ja
    "#{ object.name_ja_actual }方面"
  end

  def name_en
    "for #{ object.name_en }"
  end

end
