class TokyoMetro::Factory::Generate::Static::MetaClass::Info::Fundamental

  def generate
    self.class.info_class_for_this_class.new( *variables )
  end

  def self.process( *vars )
    self.new( *vars ).generate
  end

  def self.info_class_for_this_class
    info_class
  end

  private

  def variables
    variables_from_hash_keys
  end

  def set_values_to_hash_for_making_variables( hash_key_array: self.class.hash_keys , make_array: false , boolean: false )
    raise "Error" if boolean and make_array
    hash_key_array = [ hash_key_array ].flatten

    hash_key_array.each do | key_name |
      v = get_hash_value( key_name , boolean: boolean )
      if make_array
        if v.nil?
          v = ::Array.new
        else
          v = [v].flatten
        end
      end
      @hash_for_making_variables[ key_name ] = v
    end
  end

  alias :set_values_to_hash_for_making_variables__alias :set_values_to_hash_for_making_variables

  def variables_from_hash_keys( hash_key_array: self.class.hash_keys )
    hash_key_array.map { | key_name | get_hash_value( key_name ) }
  end

  # ハッシュからインスタンスを作成するときにハッシュの値を取得するメソッド
  # @param key [String or Symbol] ハッシュのキー
  # @param boolean [Boolean] ハッシュ (h) 内のキー (key) に対応する値が boolean か否かの設定
  # @note boolean に true を設定し、ハッシュ (h) 内にキー (key) に対応する値が存在しなかった場合は、false を返す。
  # @return [Object]
  # @return [Boolean] 変数 boolean に true を設定した場合
  def get_hash_value( key_name , boolean: false )
    if @h[ key_name ].present?
      v = @h[ key_name ]
    elsif boolean
      v = false
    else
      v = nil
    end

    if boolean and !( v.boolean? )
      raise "Error"
    end

    v
  end

end