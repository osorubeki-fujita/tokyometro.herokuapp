# ハッシュを出力用の文字列に変換するための機能を集めたモジュール
# @note インスタンスメソッドとして include する。
module TokyoMetro::Modules::Api::Info::ToStringGeneral

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    self.to_h.map { | key , value |
      " " * indent + key.ljust(32) + value.to_s
    }.join( "\n" )
  end

end