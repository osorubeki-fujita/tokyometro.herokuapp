# 列車種別の情報を扱うクラス
class TokyoMetro::Static::TrainType

  # 定数を定義するメソッド
  # @return [nil]
  def self.set_constant

    # IN_API
    ::TokyoMetro::Static::const_set( :TRAIN_TYPES_IN_API , ::TokyoMetro::Static::TrainType::InApi.generate_from_yaml )

    # COLOR
    ::TokyoMetro::Static::const_set( :TRAIN_TYPES_COLOR , ::TokyoMetro::Static::TrainType::Color.generate_from_yaml )

    # OTHER_OPERATOR - 【yamls】であることに注意
    ::TokyoMetro::Static::const_set( :TRAIN_TYPES_OTHER_OPERATOR , ::TokyoMetro::Static::TrainType::Custom::OtherOperator.generate_from_yamls )

    # DEFAULT
    h_default = ::TokyoMetro::Static::TrainType::Custom::DefaultSetting.generate_from_yaml
    ::TokyoMetro::Static::const_set( :TRAIN_TYPES_DEFAULT , h_default )

    # MAIN - 【yamls】であることに注意
    ::TokyoMetro::Static::const_set( :TRAIN_TYPES , ::TokyoMetro::Static::TrainType::Custom::Main.generate_from_yamls )

    return nil
  end

end