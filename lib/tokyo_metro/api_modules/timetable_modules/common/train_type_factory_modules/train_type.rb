module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::TrainType

  include ::TokyoMetro::CommonModules::Decision::TrainType

  private

  def is_train_type_of?( *variables )
    super( *variables , @train_type_same_as )
  end

end