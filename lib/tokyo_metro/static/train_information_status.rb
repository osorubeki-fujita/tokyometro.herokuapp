class TokyoMetro::Static::TrainInformationStatus < TokyoMetro::Static::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus

  # @!group 列車運行情報のリスト

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :TRAIN_INFORMATION_STATUSES , self.generate_from_yaml )
  end

  # @!endgroup

end