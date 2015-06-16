class TrainOwnerDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    operator.decorate.render_document_info_box
  end

end
