# リアルタイム情報のクラス属性を定義するためのモジュール
module TokyoMetro::ApiModules::ClassAttr::RealTime

  extend ::ActiveSupport::Concern

  if self.instance_methods( true ).include?( :real_time_info? )
    undef :real_time_info?
  end

  module ClassMethods

    # リアルタイムな情報を扱うクラスか否かを判定するメソッド
    # @return [Boolean]
    def real_time_info?
      true
    end

  end

end