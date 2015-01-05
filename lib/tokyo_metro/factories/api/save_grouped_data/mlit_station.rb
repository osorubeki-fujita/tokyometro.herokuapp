
__END__

# 国土交通省国土数値情報-鉄道::駅 mlit:Station のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::MlitStation < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation
  
  def self.regexp_for_filename
    /\mlit\.Station\:/
  end

end