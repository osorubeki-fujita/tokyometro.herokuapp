# 列車種別の情報を扱うクラス
class TokyoMetro::StaticDatas::TrainType

  # 定数を定義するメソッド
  # @return [nil]
  def self.set_constant

    # IN_API
    h_in_api = ::TokyoMetro::Factories::StaticDatas::TrainType::InApi.from_yaml
    ::TokyoMetro::StaticDatas::const_set( :TRAIN_TYPES_IN_API , h_in_api )

    # COLOR
    h_color = ::TokyoMetro::Factories::StaticDatas::TrainType::Color.from_yaml
    ::TokyoMetro::StaticDatas::const_set( :TRAIN_TYPES_COLOR , h_color )

    # OTHER_OPERATOR - 【yamls】であることに注意
    h_other_operator = TokyoMetro::Factories::StaticDatas::TrainType::Custom::OtherOperators.from_yamls
    ::TokyoMetro::StaticDatas::const_set( :TRAIN_TYPES_OTHER_OPERATOR , h_other_operator )

    # DEFAULT
    h_default =  ::TokyoMetro::Factories::StaticDatas::TrainType::Custom::DefaultSetting.from_yaml
    ::TokyoMetro::StaticDatas::const_set( :TRAIN_TYPES_DEFAULT , h_default )

    # MAIN - 【yamls】であることに注意
    h_main =  ::TokyoMetro::Factories::StaticDatas::TrainType::Custom::Mains.from_yamls
    ::TokyoMetro::StaticDatas::const_set( :TRAIN_TYPES , h_main )

    return nil
  end

end

# train_type/in_api.rb
# train_type/color.rb
# train_type/custom.rb