class Station::InfoDecorator::InGoogleMap < TokyoMetro::Factory::Decorate::AppSubDecorator

  def json_title
    "#{ name_ja_actual } #{ name_en }"
  end

  # @see http://qiita.com/jacoyutorius/items/a107ff6c93529b6b393e
  def src_in_iframe
    str = ::String.new
    str << "https://www.google.com/maps/embed/v1/search?key=#{ ::TokyoMetro::GOOGLE_MAP_API_KEY }&q=#{ name_ja_url_encoded }"
    str << "&center=#{ latitude },#{ longitude }"
    str << "&zoom=16"
    str << "&maptype=roadmap"
    str << "&language=ja"
    str
  end
  
  def render_map_canvas
    h.content_tag(
      :div ,
      id: :map_canvas ,
      "data-geo-lat" => object.latitude ,
      "data-geo-lng" => object.longitude ,
      "data-map-lang" => :ja ,
      "data-zoom" => 16 ,
      "data-maptype" => :roadmap
    ) do
    end
  end

  def render_embeded_map
    h.content_tag( :iframe , id: :map , src: url , frameborder: 0 ) do
    end
  end

  def render_button_to_center_of_station( request )
    h.render inline: <<-HAML , type: :haml , locals: { this: self , request: request }
%li{ class: [ :link_of_map , :to_center_of_station ] , "data-geo-lat" => this.object.latitude , "data-geo-lng" => this.object.longitude }
  %div{ class: [ :content , :clearfix ] }
    %div{ class: :icon }
      = ::TokyoMetro::App::Renderer::Icon.location( request , 1 ).render
    %div{ class: :text }
      %div{ class: :text_ja }<
        = this.render_name_ja( with_subname: false , suffix: "駅を" )
      %div{ class: :text_ja }<
        = "地図の中心にする"
      %div{ class: :text_en }<
        = this.render_name_en( with_subname: false , prefix: "Move map to " , suffix: "Sta." )
    HAML
  end

end
