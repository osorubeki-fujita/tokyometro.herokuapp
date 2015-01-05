# 東京メトロの情報のうち、変化のない（or 非常に少ない）ものを扱うモジュール
# @example
#   * TokyoMetro::StaticDatas.normal_fare
#     普通運賃の情報
#       @note {::TokyoMetro::StaticDatas::Fare.set_constant} によって定義されている。
#       @return [::TokyoMetro::StaticDatas::Fare::Normal::Table::List]
#
#   * TokyoMetro::StaticDatas.railway_lines
#   * TokyoMetro::StaticDatas.stations_in_tokyo_metro
#   * TokyoMetro::StaticDatas.stations
#   * TokyoMetro::StaticDatas.stopping_patterns （現在未定義）
#   * TokyoMetro::StaticDatas.train_types_in_api
#   * TokyoMetro::StaticDatas.train_types_color
#   * TokyoMetro::StaticDatas.train_types_other_operator
#   * TokyoMetro::StaticDatas.train_types_default
#   * TokyoMetro::StaticDatas.train_types
module TokyoMetro::StaticDatas
  
  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  # 東京メトロ オープンデータに関する定数を定義するメソッド
  # @return [nil]
  def self.set_constants

    #---- 運賃
    TokyoMetro::StaticDatas::Fare.set_constant

    #---- 方面
    TokyoMetro::StaticDatas::RailwayDirection.set_constant

    #---- 運行事業者
    TokyoMetro::StaticDatas::Operator.set_constant

    #---- 車両所有事業者
    ::TokyoMetro::StaticDatas::TrainOwner::set_constant

    #---- 鉄道路線
    ::TokyoMetro::StaticDatas::RailwayLine::set_constant

    #---- 駅情報（東京メトロのみ）
    ::TokyoMetro::StaticDatas::StationsInTokyoMetro::set_constant

    #---- 駅（他社も含む）
    ::TokyoMetro::StaticDatas::Station::set_constant

    #---- 停車駅（他社も含む）
    # ::TokyoMetro::StaticDatas::StoppingPattern::set_constant

    #---- 列車種別
    ::TokyoMetro::StaticDatas::TrainType::set_constant

    return nil
 end

  def self.railway_lines_operated_by_tokyo_metro
    railway_lines.select { | key , value | value[ "operator" ] == "odpt.Operator:TokyoMetro" }
  end

end

# static_datas/fundamental.rb

#--------

# static_datas/fare.rb
# static_datas/color.rb

# static_datas/railway_direction.rb
# static_datas/operator.rb
# static_datas/train_owner.rb

# static_datas/railway_line.rb
# static_datas/stations_in_tokyo_metro.rb
# static_datas/station.rb
#---- static_datas/stopping_pattern.rb

# static_datas/train_type.rb