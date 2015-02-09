# 各料金区間の運賃の配列を扱うクラス
# @note 通常は TokyoMetro::Fare::Normal.table から呼び出す。
class TokyoMetro::Static::Fare::Normal::Table

  include ::TokyoMetro::ClassNameLibrary::Static::Fare

  # Constructor
  # @param title [::String] 運賃表のタイトル
  # @param list [::TokyoMetro::Static::Fare::Normal::Table::List] 運賃表の配列
  # @param from [::DateTime] 改定日
  def initialize( title , ary , from )
    @title = title
    @list = ary
    @from = from
  end

  # @return [::String] 運賃表のタイトル
  attr_reader :title
  # @return [::TokyoMetro::Static::Fare::Normal::Table::List] 運賃表の配列
  attr_reader :list
  # @return [::DateTime] 改定日
  attr_reader :from
  alias :valid_from :from

  # 運賃表の情報を文字列として返すメソッド
  # @param indent [::Integer (>0)] インデントの幅
  # @return [::String]
  def to_s( indent = 0 )
    str_ary = ::Array.new

    str_ary << " " * indent + "○ #{@title} (from #{ @from.strftime("%Y.%m.%d") })"
    str_ary << @list.to_s( indent + 2 )

    str_ary.join( "\n" * 2 )
  end
  alias :to_strf :to_s

  def date_of_revision
    ::Date.new( @from.year , @from.month , @from.day )
  end

  def seed
    @list.seed( date_of_revision , ::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" ).id )
  end

  # YAML のデータからインスタンスを作成するメソッド
  # @param title [::String] 運賃表のタイトル
  # @param yaml_file [::String] YAML のファイル名
  # @return [::TokyoMetro::Static::Fare::Normal::Table]
  def self.generate_from_yaml( title , yaml_file , from )
    ary = self.normal_fare_table_list_class.new

    ::YAML.load_file( "#{db_dirname}/#{yaml_file}.yaml" ).each do |h|
      fares = [ "ticket_fare" , "child_ticket_fare" , "ic_card_fare" , "child_ic_card_fare" ].map { | key | h[ key ] }
      ary << self.normal_fare_table_pattern_class.new( *fares ).freeze
    end

    raise_error_of_element( ary )
    self.new( title , ary , from )
  end

  class << self

    private

    # 配列の要素をチェックするメソッド
    # @param ary [::Array] チェックする配列
    # @return [nil]
    def raise_error_of_element( ary )
      unless ary.all?{ |i| i.instance_of?( normal_fare_table_pattern_class ) }
        raise "Error"
      end
      return nil
    end

    # データを保存するディレクトリ
    # @return [::String]
    def db_dirname
      "#{ ::TokyoMetro::dictionary_dir }/fare"
    end

  end

end