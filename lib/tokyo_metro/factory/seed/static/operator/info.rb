class TokyoMetro::Factory::Seed::Static::Operator::Info < TokyoMetro::Factory::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::Operator
  include ::TokyoMetro::Factory::Seed::Common::Polymorphic::TwitterAccount

  def initialize( info )
    super( info , get_id: true )
  end

  private

  def hash_to_db
    h = { name_ja: @info.name_ja_inspect , name_en: @info.name_en_inspect , color: @info.web_color }

    [
      :same_as ,
      :name_ja_display , :name_ja_normal_precise , :name_ja_normal , :name_ja_for_transfer_info , :name_ja_to_haml ,
      # :name_hira ,
      :name_en_display , :name_en_normal_precise , :name_en_normal , :name_en_for_transfer_info , :name_en_to_haml ,
      :index , :operator_code , :numbering , :railway_line_code_shape , :station_code_shape ,
      :css_class_name # , :twitter_widget_id , :twitter_account
    ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    h
  end

  def seed_optional_infos
    seed_twitter_account
  end

end