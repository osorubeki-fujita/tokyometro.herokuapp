# リアルタイム情報のクラス属性を定義するためのモジュール
# @note {TokyoMetro::Api::MetaClass::RealTime}, {TokyoMetro::Api::MetaClass::RealTime::List}, {TokyoMetro::Api::MetaClass::RealTime::Info} に include する。
# @note ActiveSupport::Concern を利用している。
module TokyoMetro::Modules::Api::Common::RealTime

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