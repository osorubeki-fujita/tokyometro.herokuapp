# 個別の路線の、複数の駅情報を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::Station::InEachRailwayLine < ::TokyoMetro::StaticDatas::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station
  include ::TokyoMetro::StaticDataModules::ToFactory::GenerateFromOneYaml

  include ::TokyoMetro::StaticDataModules::Hash::Seed
  alias :__seed__ :seed

  def seed( railway_line_name , indent: 0 )
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent + 1 )
    time_begin = Time.now

    railway_line = ::RailwayLine.find_by( same_as: railway_line_name )
    if railway_line.blank?
      raise "Error: The instance of \"#{railway_line}\" does not exist in the database."
    end
    railway_line_id = railway_line.id

    self.each do | station_name , info |
      info.seed( railway_line_id , indent: indent + 3 )
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent + 2 )
  end

  def self.generate_from_yaml
    super( method_for_factory_class: :subhash_factory_class )
  end

end

# in_each_railway_line/info.rb