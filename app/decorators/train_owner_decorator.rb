class TrainOwnerDecorator < Draper::Decorator
  delegate_all
  
  def render_document_info_box
    operator.decorate.render_document_info_box
  end

end