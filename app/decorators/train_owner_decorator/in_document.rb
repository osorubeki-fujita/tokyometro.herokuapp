class TrainOwnerDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    operator.decorate.in_document.render
  end

end
