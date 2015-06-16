class TrainOwnerDecorator::InTrainLocation < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    h.render inline: <<-HAML , type: :haml , locals: { operator: object.operator }
%li{ class: [ :train_owner , :sub_info ] }
  %p{ class: :text_ja }<
    = operator.name_ja_normal + "の車両で運行"
  %p{ class: :text_en }<
    = "Cars owned by " + operator.name_en_normal
    HAML
  end

end
