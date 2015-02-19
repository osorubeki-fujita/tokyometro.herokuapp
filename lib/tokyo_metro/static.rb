# 東京メトロの情報のうち、変化のない（or 非常に少ない）ものを扱うモジュール
# @example
#   * TokyoMetro::Static.normal_fare
#     普通運賃の情報
#       @note {::TokyoMetro::Static::Fare.set_constant} によって定義されている。
#       @return [::TokyoMetro::Static::Fare::Normal::Table::List]
#
#   * TokyoMetro::Static.railway_lines
#   * TokyoMetro::Static.stations_in_tokyo_metro
#   * TokyoMetro::Static.stations
#   * TokyoMetro::Static.stopping_patterns （現在未定義）
#   * TokyoMetro::Static.train_types_in_api
#   * TokyoMetro::Static.train_types_color
#   * TokyoMetro::Static.train_types_other_operator
#   * TokyoMetro::Static.train_types_default
#   * TokyoMetro::Static.train_types
module TokyoMetro::Static

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # 東京メトロ オープンデータに関する定数を定義するメソッド
  # @return [nil]
  def self.set_constants

    #---- 運賃
    TokyoMetro::Static::Fare.set_constant

    #---- 方面
    TokyoMetro::Static::RailwayDirection.set_constant

    #---- 運行事業者
    TokyoMetro::Static::Operator.set_constant

    #---- 車両所有事業者
    ::TokyoMetro::Static::TrainOwner.set_constant

    #---- 鉄道路線
    ::TokyoMetro::Static::RailwayLine.set_constant

    #---- 駅情報（東京メトロのみ）
    ::TokyoMetro::Static::StationsInTokyoMetro.set_constant

    #---- 駅（他社も含む）
    ::TokyoMetro::Static::Station.set_constant

    #---- 停車駅（他社も含む）
    # ::TokyoMetro::Static::StoppingPattern.set_constant

    #---- 列車種別
    ::TokyoMetro::Static::TrainType.set_constant

    #---- 列車運行情報
    ::TokyoMetro::Static::TrainInformationStatus.set_constant

    #---- 曜日
    ::TokyoMetro::Static::OperationDay.set_constant

    return nil
 end

  def self.railway_lines_operated_by_tokyo_metro
    railway_lines.select { | key , value | value[ "operator" ] == "odpt.Operator:TokyoMetro" }
  end

end