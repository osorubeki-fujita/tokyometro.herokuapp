class TokyoMetro::Factories::Seed::Static::TrainType::InApi::Info < TokyoMetro::Factories::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::InApi

  private

  def hash_to_db
    h = ::Hash.new

    [
      :same_as ,
      :name_ja , :name_ja_display , :name_ja_normal ,
      :name_en , :name_en_display , :name_en_normal
    ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    h
  end

end