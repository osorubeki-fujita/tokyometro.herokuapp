# SCSS ファイルの作成に使用するメソッドを提供するモジュール
# @note TokyoMetro::Static::Operator::Hash などに include する。
module TokyoMetro::Modules::Static::Hash::MakeScss

# @!group SCSS ファイルの作成

  # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
  # @return [Const (class)]
  def self.scss_color_factory
    ::TokyoMetro::Factory::Scss::Color
  end

  # SCCS の color ファイルを作成する Factory Pattern Class のインスタンスを返すメソッド
  # @return [subclass of TokyoMetro::Factory::Scss::Color]
  def instance_of_sccs_color_factory
    ary = self.values
    self.class.scss_color_factory.new( ary )
  end

  # SCCS の color ファイルを Factory Pattern によって作成し、設定に応じて SCCS ファイルを CSS ファイルに変換するメソッド
  # @param css_fundamental [Boolean] SCSS の fundamental ファイルを変換するか否かの設定
  # @param css_color [Boolean] SCSS の color ファイルを変換するか否かの設定
  # @note TokyoMetro::Factory::Scss::Color（のサブクラス）のインスタンスが生成される。
  # @return [nil]
  def make_scss_color_file( css_fundamental: true , css_color: true )
    factory = instance_of_sccs_color_factory
    factory.generate_file
    factory.convert_files( css_fundamental , css_color )

    return nil
  end

# @!endgroup

end