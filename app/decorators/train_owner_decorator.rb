class TrainOwnerDecorator < Draper::Decorator
  delegate_all

  def in_document
    ::TrainOwnerDecorator::InDocument.new( self )
  end

  def in_train_location
    ::TrainOwnerDecorator::InTrainLocation.new( self )
  end

end
