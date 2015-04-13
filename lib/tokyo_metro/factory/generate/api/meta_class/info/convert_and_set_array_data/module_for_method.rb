# 配列のデータを JSON のハッシュから変換するメソッドを提供するモジュール
# @note このモジュールが include されたクラスのインスタンスは、{#convert_and_set_array_data} を用いることで{::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::FactoryClass.process}を呼び出すことができる。
module TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::ModuleForMethod

  private

  # {::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::FactoryClass.process} によりハッシュの値として格納されている配列を変換するメソッド
  def covert_and_set_array_data( key_str , list_class , info_class = nil , to_flatten: false )
    if @hash[ key_str ].present?
      ::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::FactoryClass.process( @hash[ key_str ] , list_class , info_class , to_flatten )
    else
      nil
    end
  end

end