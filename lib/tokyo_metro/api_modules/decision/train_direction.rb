module TokyoMetro::ApiModules::Decision::TrainDirection

  # @!group 方面に関するメソッド

  def direction_a?
    /\AA/ =~ @train_number
  end

  def direction_b?
    /\AB/ =~ @train_number
  end

  alias :is_direction_a? :direction_a?
  alias :is_direction_b? :direction_b?

  alias :a_line? :direction_a?
  alias :b_line? :direction_b?

end