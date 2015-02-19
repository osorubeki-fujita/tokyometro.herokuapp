# テストに使用するメソッドを提供するモジュール
module TokyoMetro::Modules::Static::Hash::DefineTest

  # テスト用メソッド
  # @param title [Strng] 表示するタイトル（設定しない場合は、ハッシュの上位の名前空間の名称）
  # @return [nil]
  def define_test( title = self.class.toplevel_namespace )
    puts "\*" * 96
    puts ""
    puts "● #{title}"
    puts ""
    self.values.sort.each do |v|
      puts ( v.to_s )
      puts "\n"
    end
    puts "\n" * 2

    puts "○ Class"
    puts self.values.map { |v| v.class.name }.uniq.sort
    puts ""
    puts "○ Keys"
    puts self.keys.sort
    puts "\n" * 2

    return nil
  end

end