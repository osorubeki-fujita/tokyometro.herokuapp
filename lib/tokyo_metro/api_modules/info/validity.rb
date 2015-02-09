# 有効期限の判定機能を提供するモジュール
# @note インスタンスメソッドを組み込むために、クラスに【include】するモジュール
module TokyoMetro::ApiModules::Info::Validity

# @!group 運行情報のメタデータ (For developers)

  # 有効期限内であるか否かを判定するメソッド
  # @return [Boolean]
  def valid?( time = ::TokyoMetro.time_now )
    @valid > time
  end

# @!endgroup

end