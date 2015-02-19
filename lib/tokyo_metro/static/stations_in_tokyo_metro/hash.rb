# 複数の駅の情報（名称、管理事業者など）を扱うクラス（ハッシュ）
class TokyoMetro::Static::StationsInTokyoMetro::Hash < ::TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro
  include ::TokyoMetro::Modules::Static::Hash::MakeScss

  # テスト用メソッド
  # @param title [Strng] 表示するタイトル（設定しない場合は、ハッシュの上位の名前空間の名称）
  # @return [nil]
  def define_test( title = self.class.upper_namespace.name )
    super( title )

    puts "間違っている駅名"
    self.each_value do | station |
      unless station.invalid_names_hira.empty?
        puts station.invalid_names_hira.to_s
      end
      unless station.regexp_of_invalid_inputs.empty?
        puts station.regexp_of_invalid_inputs.to_s
      end
    end

    return nil
  end

end