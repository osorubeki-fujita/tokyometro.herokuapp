class Operator::AsTrainOwnerDecorator < Draper::Decorator
  delegate_all

  def in_document
    ::Operator::AsTrainOwnerDecorator::InDocument.new( self )
  end

  def in_train_location
    ::Operator::AsTrainOwnerDecorator::InTrainLocation.new( self )
  end

end
