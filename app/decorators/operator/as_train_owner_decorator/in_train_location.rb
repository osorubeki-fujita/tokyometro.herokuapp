class Operator::AsTrainOwnerDecorator::InTrainLocation < TokyoMetro::Factory::Decorate::SubDecorator

  def render
    h.render inline: <<-HAML , type: :haml , locals: { info: object.info }
%li{ class: [ :train_owner , :sub_info ] }
  %p{ class: :text_ja }<
    = info.name_ja_normal_precise + "の車両で運行"
  %p{ class: :text_en }<
    = "Cars owned by " + info.name_en_normal_precise
    HAML
  end

end
