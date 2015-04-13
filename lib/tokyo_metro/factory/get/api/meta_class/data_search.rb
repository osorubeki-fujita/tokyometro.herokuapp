# API からデータを取得するための Factory Pattern のクラス（データ検索 API を利用する場合）
class TokyoMetro::Factory::Get::Api::MetaClass::DataSearch < TokyoMetro::Factory::Get::Api::MetaClass::Fundamental

  private

  # HTTP クライアントに渡すパラメーターを設定するメソッド (private)
  # @param h [Hash] パラメーターのハッシュ
  # @param key [String] パラメーターのハッシュに設定するキー
  # @param value [Object] パラメーターのハッシュに設定するキーに対応する値
  # @param class_type [::Array <Const>] value のクラス
  # @return [nil]
  def set_parameter_send_to_api( h , key , value , *class_type )
    if ( class_type.include?( Integer ) and value.integer? ) or class_type.include?( value.class )
      h[ key ] = value.to_s
    elsif value.present?
      raise "Error"
    end
    return nil
  end

  def access_point_url
    ::TokyoMetro::DATAPOINTS_URL
  end

end