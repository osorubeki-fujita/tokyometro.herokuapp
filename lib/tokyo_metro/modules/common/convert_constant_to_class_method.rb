# 定数をクラスメソッドのように扱う機能を提供するモジュール
# @note このモジュールを include したクラスやモジュールでは、定数をクラスメソッドのように呼び出すことができる。
# @note クラスメソッドのように呼び出したくない定数がある場合は、include されたクラスの内部でその定数の名称（シンボル）のリスト（配列）を private なクラスメソッド constants_not_converted_by_method_missing で指定する。
# @note {TokyoMetro} に対しては、このモジュールが定義されているファイルで include している。
module TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  extend ::ActiveSupport::Concern

  module ClassMethods

    def method_missing( method_name , *args )
      if costants_converted_by_method_missing.include?( method_name.upcase )
        return const_get( method_name.upcase )
      else
        super( method_name , *args )
      end
    end

    private

    def costants_converted_by_method_missing
      constants( false ) - constants_not_converted_by_method_missing
    end

    def constants_not_converted_by_method_missing
      []
    end

  end

end

::TokyoMetro.module_eval do
  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod
end