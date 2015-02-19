module TokyoMetro::Modules::Api::Info::Decision::TrainType

  include ::TokyoMetro::Modules::Common::Info::Decision::TrainType

  private

  def train_type_of?( *args , compared: @train_type )
    super( *args , compared )
  end

  alias :is_train_type_of? :train_type_of?

  def train_of?( *args , compared: @train_name )
    super( *args , compared )
  end

  alias :is_train_of? :train_of?

end