# 複数の路線の駅情報を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::Station::RailwayLines < ::TokyoMetro::StaticDatas::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station

  include ::TokyoMetro::StaticDataModules::Hash::Seed
  alias :__seed__ :seed

  # ハッシュのそれぞれの値（インスタンスの情報）をDBに流し込むメソッド
  # @return [nil]
  # @note Seed#process_stations では、この処理の実行前に{TokyoMetro::Api::Station::List.seed}が呼び出される。
  def seed( indent: 0 )
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent + 1 )
    time_begin = Time.now

    self.each do | line_name , in_each_line |
      puts " " * 4 * ( indent + 2 ) + "※ #{line_name}"
      puts ""
      in_each_line.seed( line_name , indent: indent + 3 )
    end

    seed_stations_used_in_direction_or_connecting_railway_lines

    ::TokyoMetro::Seed::Inspection.time( time_begin )
  end

  # テスト用メソッド
  # @param title [Strng] 表示するタイトル（設定しない場合は、ハッシュの上位の名前空間の名称）
  # @return [nil]
  def define_test( title = self.class.upper_namespace.name )
    puts "\*" * 96
    puts ""
    puts "● #{title}"
    puts ""

    puts "○ Class"
    puts self.values.map { |v| v.class.name }.uniq.sort
    puts ""
    puts "○ Keys"
    puts self.keys
    puts "" * 2

    puts "○ First Value (#{self.keys.first})"
    puts ""
    first_value = self.values.first
    puts "\[Keys\]"
    puts ""
    puts first_value.keys
    puts ""
    puts "\[Values\]"
    puts first_value.values.map { | v | v.class.name }.uniq.sort

    puts ""
    puts "-" * 64
    puts ""

    [ "odpt.Railway:TokyoMetro.Ginza" , "odpt.Railway:TokyoMetro.Fukutoshin" , "odpt.Railway:Odakyu.Odawara" ].each do | line |
      puts "Line: #{ line }"
      puts ""
      self[ line ].each do | station , info |
        puts info.to_s
      end
      puts "" * 2
    end

    return nil
  end

  private

  def seed_stations_used_in_direction_or_connecting_railway_lines
    ::YAML.load_file( "#{ ::TokyoMetro::DICTIONARY_DIR }/additional_datas/station/in_other_operators/appeared_in_connecting_railway_line_info.yaml" ).each do | station |
      railway_line_id = ::RailwayLine.find_by( same_as: station[ "railway_line" ] ).id
      h = {
        name_ja: station[ "name_ja" ] ,
        name_hira: station[ "name_hira" ] ,
        name_in_system: station[ "name_in_system" ] ,
        name_en: station[ "name_en" ] ,
        same_as: station[ "same_as" ] ,
        railway_line_id: railway_line_id
      }
      ::Station.create(h)
    end
  end

  def seed_instance_for_escaping_undefined
    ::Station.create( same_as: "Undefined" , name_ja: "未定義" , name_en: "Undefined" , railway_line_id: ::RailwayLine.find_by( same_as: "Undefined" ) )
  end

end