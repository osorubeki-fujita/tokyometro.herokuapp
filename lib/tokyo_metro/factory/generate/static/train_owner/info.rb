class TokyoMetro::Factory::Generate::Static::TrainOwner::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Static::TrainOwner

  # Constructor
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param value [Hash] 鉄道事業者の ID キー（この ID キーをもとに、クラスメソッド（定数） TokyoMetro::Static.operators から鉄道事業者の情報を取得する）
  def initialize( same_as , operator_name )
    @same_as = same_as
    @operator_name = operator_name
  end

  private

  def variables
    [ @same_as , operator_instance_in_api ]
  end

  def operator_instance_in_api
    operator = ::TokyoMetro::Static.operators[ @operator_name ]

    if operator.nil?
      puts @operator_name.class.name
      puts @operator_name.to_s
      puts @same_as
      raise "Error: \[operator_name\] \"#{@operator_name}\" for the id key \"#{@same_as}\" does not exist."
    end

    operator
  end

  undef :variables_from_hash_keys

end