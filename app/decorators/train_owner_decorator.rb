class TrainOwnerDecorator < Draper::Decorator
  delegate_all

  def render_document_info_box
    operator.decorate.render_document_info_box
  end

  def render_in_train_location
    h.render inline: <<-HAML , type: :haml , locals: { operator: object.operator }
%li{ class: [ :train_owner , :sub_info ] }
  %p{ class: :text_ja }<
    = operator.name_ja_normal + "の車両で運行"
  %p{ class: :text_en }<
    = "Cars owned by " + operator.name_en_normal
    HAML
  end

end
