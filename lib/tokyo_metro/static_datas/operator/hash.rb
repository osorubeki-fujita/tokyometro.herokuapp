# 複数の鉄道事業者の情報を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::Operator::Hash < ::TokyoMetro::StaticDatas::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Operator
  include ::TokyoMetro::StaticDataModules::Hash::Seed
  include ::TokyoMetro::StaticDataModules::Hash::MakeScss
  # include ::TokyoMetro::StaticDataModules::Hash::ProcessHaml

  alias :__seed__ :seed

  def seed
    seed_main
    seed_instance_for_escaping_undefined
  end

  # テスト用メソッド
  # @param title [Strng] 表示するタイトル（設定しない場合は、ハッシュの上位の名前空間の名称）
  # @return [nil]
  def define_test( title = self.class.upper_namespace.name )
    super( title )
    puts ""
    puts "○ CSS class name"
    puts self.values.map { |i| i.css_class_name }

    return nil
  end

  private

  def seed_main
    self.__seed__
  end

  def seed_instance_for_escaping_undefined
    ::Operator.create( same_as: "odpt.Operator:Undefined" , name_ja: "未定義" , name_en: "Undefined" )
  end

end