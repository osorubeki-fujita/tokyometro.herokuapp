module TokyoMetro::ApiModules::Decision::TrainType

  include ::TokyoMetro::CommonModules::Decision::TrainType

  private

  def is_train_type_of?( *variables )
    super( *variables , @train_type )
  end

end