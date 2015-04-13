class TokyoMetro::Factory::Generate::Static::Operator::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::Operator

  def self.hash_keys
    [
      :name_ja , :name_ja_display , :name_en , :name_en_display , :index ,
      :operator_code , :numbering ,
      :railway_line_code_shape , :station_code_shape , :color ,
      :twitter_widget_id , :twitter_account
    ]
  end

  private

  def set_values_to_hash_for_making_variables
    super( hash_key_array: [ :name_ja , :name_en ] , make_array: true )
    super( hash_key_array: [ :name_ja_display , :name_en_display , :index , :operator_code , :railway_line_code_shape , :station_code_shape , :color ] )
    super( hash_key_array: [ :twitter_widget_id , :twitter_account ] )
    super( hash_key_array: :numbering , boolean: true )

    unless has_color?
      raise "Error"
    end

    @hash_for_making_variables[ :color ] = ::TokyoMetro::Static::Color::generate_from_hash( @h[ :color ] )

    if has_number? and !( has_railway_line_code? ) and has_no_station_code?
      @hash_for_making_variables[ :railway_line_code_shape ] = "none"
    end
  end

  def has_color?
    @hash_for_making_variables[ :color ].present?
  end

  def has_number?
    @hash_for_making_variables[ :numbering ]
  end

  def has_railway_line_code?
    @hash_for_making_variables[ :railway_line_code_shape ].present?
  end

  def has_no_railway_line_code?
    @hash_for_making_variables[ :railway_line_code_shape ] == "none"
  end

  def has_no_station_code?
    @hash_for_making_variables[ :station_code_shape ] == "none"
  end

end