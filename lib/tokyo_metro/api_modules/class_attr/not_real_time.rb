# リアルタイムでない情報を扱うクラスに組み込むモジュール
module TokyoMetro::ApiModules::ClassAttr::NotRealTime

  extend ::ActiveSupport::Concern

  module ClassMethods

    # リアルタイムな情報を扱うクラスか否かを判定するメソッド
    # @return [Boolean]
    def real_time_info?
      false
    end

  end

end