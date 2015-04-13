class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo::Alphabet < TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
    # 駅名を表す正規表現
    regexp_of_station_name = /\A([A-Za-z]+)\.([A-Z])([a-z]+)/
    unless regexp_of_station_name === str
      raise "Error: \"#{str}\" (Class: #{str.class.name} / from: #{key} (#{key.class.name})) is not valid."
    end
    # $1 ... 鉄道事業者の名称
    # $2 ... 駅名の頭文字
    # $2 + $3 ... 駅名
    str.gsub( regexp_of_station_name ) { "#{$1}\/#{$2}\/#{$2}#{$3}" }
  end

end