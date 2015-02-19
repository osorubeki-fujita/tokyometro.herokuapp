# インスタンスをハッシュに変換して返すときに使用するメソッドを集めたモジュール
# @note インスタンスメソッドとして include する。
module TokyoMetro::Modules::Api::Info::SetDataToHash

  private

  # インスタンスをハッシュに変換して返すときに、ハッシュにインスタンス変数を格納するメソッド
  # @param h [Hash] API から取得したデータのハッシュ
  # @param k [String or Symbol] ハッシュのキー
  # @param v [Object] ハッシュの値
  # @return [nil]
  def set_data_to_hash( h , k , v )
    if v.present?
      h[ k ] = v
    end
    return nil
  end

end