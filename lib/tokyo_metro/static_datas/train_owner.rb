# 車両所有事業者の情報を扱うクラス
class TokyoMetro::StaticDatas::TrainOwner < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingOneYaml

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::TrainOwner

  # 定数を設定するクラスメソッド
  # @return [nil]
  def self.set_constant
    ::TokyoMetro::StaticDatas.const_set( :TRAIN_OWNERS , factory_class.from_yaml )
  end

end

# train_owner/info.rb
# train_owner/hash.rb

__END__


  def self.define_operator_method( method_name )
    instance_eval <<-END_OF_DEF
      def #{method_name.to_s}()
        @operator.__send__( method_name )
      end
    END_OF_DEF
  end

  [ :name , :name_en , :order , :numbering , :railway_line_code_shape , :station_code_shape , :color , :web_color , :red , :green , :blue ].each do | method_name |
      define_operator_method( method_name )
  end