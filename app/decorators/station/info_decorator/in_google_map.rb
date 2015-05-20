class Station::InfoDecorator::InGoogleMap < ::TokyoMetro::Factory::Decorate::AppSubDecorator

  def json_title
    "#{ name_ja_actual } #{ name_en }"
  end

  # @see http://qiita.com/jacoyutorius/items/a107ff6c93529b6b393e
  def url
    str = ::String.new
    str << "https://www.google.com/maps/embed/v1/search?key=#{ ::TokyoMetro::GOOGLE_MAP_API_KEY }&q=#{ station_name_url_encoded }"
    str << "&center=#{ latitude },#{ longitude }"
    str << "&zoom=16"
    str << "&maptype=roadmap"
    str << "&language=ja"
    str
  end

end