# インスタンスをハッシュに変換し、さらに JSON の文字列に変換するための機能を集めたモジュール
# @note インスタンスメソッドとして include する。
module TokyoMetro::Modules::Api::Info::ToJson

  # インスタンスをハッシュに変換し、さらに JSON の文字列に変換するメソッド
  # @return [String (JSON)]
  def to_json
    self.to_h.to_s.encode( "UTF-8" )
  end

end