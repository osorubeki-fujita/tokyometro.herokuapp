# 配列のデータを JSON のハッシュから変換するメソッドを提供するモジュール
# @note このモジュールが include されたクラスのインスタンスは、{#convert_and_set_array_data} を用いることで{::TokyoMetro::Factories::Api::ConvertAndSetArrayData.process}を呼び出すことができる。
module TokyoMetro::ApiModules::ToFactoryClass::ConvertAndSetArrayData

  private

  # {::TokyoMetro::Factories::Api::ConvertAndSetArrayData.process}によりハッシュの値として格納されている配列を変換するメソッド
  def covert_and_set_array_data( key_str , list_class , info_class = nil , generate_info_instance: false , to_flatten: false )
    ::TokyoMetro::Factories::Api::ConvertAndSetArrayData.process( @hash , key_str , list_class , info_class , generate_info_instance , to_flatten )
  end

end