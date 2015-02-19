# 各路線の情報の配列
class TokyoMetro::Api::RailwayLine::List < TokyoMetro::Api::MetaClass::Hybrid::List

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 3 )
  end

  def sort_by_railway_line_order
    self.class.new( self.sort_by { | railway_line | ::TokyoMetro::Static.railway_lines[ railway_line.same_as ].order } )
  end

  [ :station_order_infos , :travel_time_infos , :women_only_car_infos ].each do | method_base_name |
    eval <<-DEF

      def seed_#{ method_base_name }
        __seed__(
          factory_name: "factory_for_seeding_list_of_#{ method_base_name }" ,
          method_name: __method__ ,
          not_on_the_top_layer: false ,
          display_number: true
        )
      end

    DEF
  end

  # @note 使用停止中
  undef :seed_station_order_infos

end