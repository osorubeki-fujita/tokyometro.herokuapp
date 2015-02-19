module TokyoMetro::Modules::Api::Info::Decision::TrainDirection

  # @!group 方面に関するメソッド

  def direction_a?
    /\AA/ === @train_number
  end

  def direction_b?
    /\AB/ === @train_number
  end

  [ :a , :b ].each do | key |
    [ "#{key}_direction?" , "#{key}_line?" , "line_#{key}?" ].each do | method_base_name |
      eval <<-ALIAS
        alias :#{method_base_name} :direction_#{key}?
        alias :is_#{method_base_name} :direction_#{key}?
      ALIAS
    end
  end

  # @!endgroup

end