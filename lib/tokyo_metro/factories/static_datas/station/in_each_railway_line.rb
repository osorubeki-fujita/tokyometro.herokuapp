# 駅の情報（他社線も含む）を扱うクラスのハッシュ (default) を作成するための Factory クラス (1)
class TokyoMetro::Factories::StaticDatas::Station::InEachRailwayLine < TokyoMetro::Factories::StaticDatas::MetaClass::EachFileForMultipleYamls

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station

  def self.from_yaml( filename )
    super( filename , method_for_hash_class: :subhash_class )
  end

  private

  def generate_procedure( h_yaml , h_new )
    h_yaml.each_with_index do | ( key , value ) , i |
      h_new[ key ] = self.class.info_class.generate_from_hash( key , value , i )
    end
    h_new
  end

end