module TokyoMetro::Modules::Common::Info::Decision::TrainType

  # @!group 列車種別に関するメソッド

  ::YAML.load_file( "#{ ::TokyoMetro.dictionary_dir }/train_type_basename_in_api.yaml" ).each do | train_type_basename |
    method_base_name = train_type_basename.underscore.downcase
    train_type_in_api = "odpt.TrainType:TokyoMetro.#{ train_type_basename }"
    eval <<-DEF
      def #{ method_base_name }?
        train_type_of?( \"#{ train_type_in_api }\" )
      end

      #-------- [alias]
      alias :is_#{ method_base_name }? :#{ method_base_name }?
      alias :#{ method_base_name }_train? :#{ method_base_name }?
      alias :is_#{ method_base_name }_train? :#{ method_base_name }?
    DEF
  end

  # @!group 普通・急行の上書き（都営三田線対策）

  [ :local , :express ].each do | method_base_name |
    [ method_base_name , "is_#{method_base_name}" , "#{method_base_name}_train" , "is_#{method_base_name}_train" ].each do | specific_method_base_name |
      eval <<-ALIAS
        alias :__#{specific_method_base_name}__? :#{specific_method_base_name}?
      ALIAS
    end
  end

  def local?
    __local__? or train_type_of?( "odpt.TrainType:Toei.Local" )
  end

  def express?
    __express__? or train_type_of?( "odpt.TrainType:Toei.Express" )
  end

  [ :local , :express ].each do | method_base_name |
    [ "is_#{method_base_name}" , "#{method_base_name}_train" , "is_#{method_base_name}_train" ].each do | specific_method_base_name |
      eval <<-ALIAS
        alias :#{specific_method_base_name}? :#{specific_method_base_name}?
      ALIAS
    end

    [ method_base_name , "is_#{method_base_name}" , "#{method_base_name}_train" , "is_#{method_base_name}_train" ].each do | specific_method_base_name |
      eval <<-PRIVATE
        private :__#{method_base_name}__?
      PRIVATE
    end
  end

  # @!group 不明・臨時

  [ :unknown , :extra ].each do | train_type |
    eval <<-DEF
      def #{ train_type }_train?
        train_type_of?( "odpt.TrainType:TokyoMetro.#{ train_type.capitalize }" )
      end

      #-------- [alias]
      alias :is_#{ train_type }_train? :#{ train_type }_train?
    DEF
  end

  # @!group ロマンスカー関連

  def limited_express_or_romance_car?
    limited_express? or romance_car? or romance_car_specific_train?
  end

  alias :is_limited_express_or_romance_car? :limited_express_or_romance_car?

  [ :limited_express_or_romance_car_train , :limited_express_train_or_romance_car_train ].each do | method_base_name |
    eval <<-ALIAS
      alias :#{method_base_name}? :limited_express_or_romance_car?
      alias :is_#{method_base_name}? :limited_express_or_romance_car?
    ALIAS
  end

  def romance_car_specific_train?
    train_of?( ::TokyoMetro::Modules::Common::Dictionary::RomanceCar.train_name.values )
  end

  alias is_romance_car_specific_train? :romance_car_specific_train?

  # @!endgroup

  private

  def train_type_of?( *args , compared )
    compare_base( args , compared )
  end

  alias :is_train_type_of? :train_type_of?

  def train_of?( *args , compared )
    compare_base( args , compared )
  end

  alias :is_train_of? :train_of?

  # 「化け種別」の判定
  # @todo 具体的な定義
  def change_into?( on: nil , at: nil )
    if on.present?
      nil
    else
      nil
    end
  end

end