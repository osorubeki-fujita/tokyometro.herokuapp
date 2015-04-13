class TokyoMetro::Factory::Seed::Static::TrainType::Custom::Main::Info < TokyoMetro::Factory::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::TrainTypeInApi

  private

  def hash_to_db
    h = ::Hash.new

    [
      :same_as , :note ,
      :css_class_name , :css_class_name_in_document
    ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    h[ :train_type_in_api_id ] = train_type_in_api_id
    h[ :railway_line_id ] = railway_line_id
    h[ :color ] = @info.color.web_color
    h[ :bgcolor ] = @info.bgcolor.web_color

    h
  end

  [ :train_type_in_api_in_db , :train_type_in_api_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @info.train_type.same_as )
        super( whole , search_by: search_by )
      end
    DEF
  end

end