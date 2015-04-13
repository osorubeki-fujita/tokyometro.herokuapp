class TrainTypeInApiDecorator < Draper::Decorator
  delegate_all

  def render_name_in_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :text_ja }<
  = info.name_ja_normal
%div{ class: :text_en }<
  = info.name_en_normal
    HAML
  end

  def render_name_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :name_ja_normal }<
  = info.name_ja_normal
%div{ class: :name_en_normal }<
  = info.name_en_normal
    HAML
  end

  def render_name_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :name_ja_normal }<
  = info.name_ja_normal
    HAML
  end

  def render_in_train_location
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :train_type }
  %div{ class: :text_ja }<
    = info.name_ja_normal
    HAML
  end

end