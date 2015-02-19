# 複数の路線の駅情報を扱うクラス（ハッシュ）
class TokyoMetro::Static::Station::RailwayLines < ::TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::Station
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Hash

  def self.factory_for_seeding_this_class
    factory_for_seeding_hash
  end

  def list
    self.values.map( &:stations )
  end

  # ハッシュのそれぞれの値（インスタンスの情報）をDBに流し込むメソッド
  # @return [nil]
  # @note {TokyoMetro::Api::Station::List.seed} から呼び出される。
  def seed
    super( indent: 1 , not_on_the_top_layer: true )
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

end