class TokyoMetro::Factory::Generate::Static::TrainType::Color::Info < TokyoMetro::Factory::Generate::Static::Color::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Color

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param h [Hash] ハッシュ
  def initialize( same_as , h )
    @same_as = same_as
    super(h)
  end

  def self.info_class_for_this_class
    info_class
  end

  def self.hash_keys
    [ :same_as , :note ] + hash_keys_of_color
  end

  private

  def variables
    [ @same_as , get_hash_value( :note ) ] + color_variables
  end

end