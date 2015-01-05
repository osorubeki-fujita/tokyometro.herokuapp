# 鉄道事業者の情報を扱うクラス
class TokyoMetro::StaticDatas::Operator < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Operator

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :OPERATORS , self.generate_from_yaml )
  end

end

__END__

  def self.define_color_method( method_name )
    instance_eval <<-END_OF_DEF
      def #{method_name.to_s}()
        @color.__send__( method_name )
      end
    END_OF_DEF
  end

  [ :web_color , :red , :green , :blue ].each do | method_name |
      define_color_method( method_name )
  end