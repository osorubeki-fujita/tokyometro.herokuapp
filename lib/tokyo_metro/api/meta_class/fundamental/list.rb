# API から提供されるデータを格納する配列（メタクラス）
class TokyoMetro::Api::MetaClass::Fundamental::List < ::Array

  include ::TokyoMetro::ApiModules::Common::NotRealTime

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @param empty_line [Integer (>=0)] 間に入れる空行の数
  # @return [String]
  def to_strf( indent = 0 , empty_line = 2 )
    self.map { |i| i.to_strf( indent ) }.join( "\n" * ( empty_line + 1 ) )
  end

end

__END__

  # 各要素を文字列に変換した上で、自身の配列を文字列に変換するメソッド
  # @return [String]
  def to_s
    self.map( &:to_s ).to_s
  end

  # 各要素を文字列に変換し、1行空けて連続した文字列にするメソッド
  # @return [String]
  def to_str_line( i = 1)
    self.map( &:to_s ).join( "\n" * ( i + 1) )
  end