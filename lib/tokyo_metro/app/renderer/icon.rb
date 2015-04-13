module TokyoMetro::App::Renderer::Icon

  FONT_AWESOME_ICON = ::YAML.load_file( "#{ ::TokyoMetro::DICTIONARY_DIR }/view/icon/font_awesome_icon.yaml" )
  IMAGE = ::YAML.load_file( "#{ ::TokyoMetro::DICTIONARY_DIR }/view/icon/image.yaml" )

  def self.font_awesome_icons
    FONT_AWESOME_ICON
  end

  def self.images
    IMAGE
  end

  FONT_AWESOME_ICON.each do | key , value |
    eval <<-DEF
      def self.#{ key }( request , size = 1 , rotation: nil )
        FontAwesome.new( request , "#{ value }" , size , rotation: rotation )
      end
    DEF
  end

  IMAGE.each do | key , value |
    eval <<-DEF
      def self.#{ key }( request , size = 1 , class_name: nil )
        Image.new( request , "#{ value }" , class_name: class_name )
      end
    DEF
  end

end