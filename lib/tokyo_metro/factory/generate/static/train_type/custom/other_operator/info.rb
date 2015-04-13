class TokyoMetro::Factory::Generate::Static::TrainType::Custom::OtherOperator::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::OtherOperator
  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  TITLE = "TrainTypeOtherOperator"

  def self.hash_keys
    hash_keys_1 + hash_keys_2
  end

  def self.hash_keys_1
    [ :train_type , :bgcolor , :color ]
  end

  def self.hash_keys_2
    [ :operator , :railway_line ]
  end

  private

  def inspect_title
    puts "○ #{TITLE} #{ @same_as }"
  end

  def variables_from_hash_keys
    hash_keys = self.class.hash_keys_1 + self.class.hash_keys_2
    super( hash_key_array: hash_keys )
  end

  def set_values_to_hash_for_making_variables
    @hash_for_making_variables[ :train_type ] = train_type

    [ :bgcolor , :color ].each do | key_name |
      @hash_for_making_variables[ key_name ] = color_info( key_name )
    end

    super( hash_key_array: [ :operator , :railway_line ] )
  end

  def train_type
    train_type = get_hash_value( :train_type )
    unless train_type.string?
      puts @h.to_s
      puts @h.keys
      puts @h.keys.first.class
      raise "Error: \"#{ train_type.to_s }\" (#{train_type.class.name}) is not valid. (Key: :train_type )"
    end
    t = ::TokyoMetro::Static.train_types_in_api[ train_type ]
    if t.nil?
      raise "Error: #{ train_type }"
    end
    t
  end

  def color_info( key_name )
    info = get_hash_value( key_name )
    unless info.kind_of?( ::Hash )
      raise "Error: #{ info.to_s } (key: #{ key_name } / class: #{ info.class.name })"
    end

    case info.keys
    # キーに ref のみが指定されている場合
    when [ "ref" ]
      # 参照のためのキー
      key_for_reference = info[ "ref" ]
      # 標準色として定義された色を取得する
      color = ::TokyoMetro::Static.train_types_color[ key_for_reference ]
      unless color.instance_of?( ::TokyoMetro::Static::TrainType::Color::Info )
        raise "Error: #{color.class.name}"
      end
      color

    # キーに line_color のみが指定されている場合
    when [ "line_color" ]
      key_of_line_color = info[ "line_color" ]
      # ラインカラーを取得する
      ::TokyoMetro::Static.railway_lines.select_main_color( key_of_line_color )

    # キーに web, red, green, blue がそれぞれ指定されている場合
    when [ "web" , "red" , "green" , "blue" ]
      # 新たに色情報のインスタンスを作成する
      ::TokyoMetro::Static::Color.generate_from_hash( info )
    else
      raise "Error"
    end
  end

  def check_varidity_of_referenced_info( info )
    super( info , include_ancestors: true )
  end

end