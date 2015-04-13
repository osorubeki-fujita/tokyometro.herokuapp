class TokyoMetro::Factory::Generate::Static::RailwayLine::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine::SetStartOn

  def self.hash_keys
    [ :name_ja , :name_hira , :name_en , :name_code , :operator , :index , :color , :start_on , :twitter_widget_id , :twitter_account ]
  end

  private

  def set_values_to_hash_for_making_variables
    super( hash_key_array: [ :name_ja , :name_hira , :name_en , :name_code ] , make_array: true )
    super( hash_key_array: [ :twitter_widget_id , :twitter_account ] )

    @hash_for_making_variables[ :color ] = color_instance
    @hash_for_making_variables[ :operator ] = operator_instance
    @hash_for_making_variables[ :start_on ] = set_start_on( @h[ :start_on ] )
  end

  # 事業者のインスタンスを取得するメソッド
  # @return [::TokyoMetro::Static::Operator::Info]
  def operator_instance
    operator = ::TokyoMetro::Static.operators[ @h[ :operator ] ]
    raise "Error: The operator is not defined." if operator.nil?
    operator
  end

  # 色情報のインスタンスを取得するメソッド
  # @param color_base [Hash or ::Array<Hash>] 色情報のもととなるハッシュ（またはハッシュの配列）
  # @return [::TokyoMetro::Static::Color] 与えられた変数 color_base がハッシュの場合
  # @return [::Array <::TokyoMetro::Static::Color>] 与えられた変数 color_base がハッシュの配列の場合
  def color_instance
    color_base = @h[ :color ]
    if color_base.nil?
      nil
    elsif color_base.kind_of?( ::Hash )
      [ ::TokyoMetro::Static::Color.generate_from_hash( color_base ) ]
    elsif color_base.instance_of?( ::Array ) and color_base.all? { |i| i.kind_of?( ::Hash ) }
      color_base.map { | each_color | ::TokyoMetro::Static::Color::generate_from_hash( each_color ) }
    else
      raise "Error"
    end
  end

end