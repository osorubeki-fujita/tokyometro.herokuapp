# リアルタイムでない情報を扱うクラスに組み込むモジュール
# @note {TokyoMetro::Api::MetaClass::Fundamental} などに include する。
# @note ActiveSupport::Concern を利用している。
module TokyoMetro::Modules::Api::Common::NotRealTime

  extend ::ActiveSupport::Concern

  module ClassMethods

    # リアルタイムな情報を扱うクラスか否かを判定するメソッド
    # @return [Boolean]
    def real_time_info?
      false
    end

  end

end