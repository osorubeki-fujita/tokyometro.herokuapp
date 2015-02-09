module TokyoMetro::DbModules::Decision::TrainType

  include ::TokyoMetro::CommonModules::Info::Decision::TrainType

  private

  def train_type_of?( *args , compared )
    super( *args , train_type.same_as )
  end

  alias :is_train_type_of? :train_type_of?

  def train_of?( *args , compared )
    super( *args , train_name.same_as )
  end

  alias :is_train_of? :train_of?

end