module TokyoMetro::Modules::Common::Info::Decision::RomanceCar

  # @!group ロマンスカーに関連するメソッド

  # ロマンスカーの特定の列車か否かを判定するメソッド
  # @return [Boolean]
  def romance_car_specific_train_on_chiyoda_line?
    chiyoda_line? and romance_car_specific_train?
  end

  # ロマンスカーか否かを判定するメソッド
  # @return [Boolean]
  def romance_car_on_chiyoda_line?
    chiyoda_line? and limited_express_or_romance_car?
  end

  alias :romance_car_train_on_chiyoda_line? :romance_car_on_chiyoda_line?

  #-------- [alias]
  [ :romance_car_specific_train_on_chiyoda_line , :romance_car_on_chiyoda_line , :romance_car_train_on_chiyoda_line ].each do | method_base_name |
    eval <<-ALIAS
      alias :is_#{ method_base_name }? :#{ method_base_name }?
    ALIAS
  end

  # @!endgroup

end