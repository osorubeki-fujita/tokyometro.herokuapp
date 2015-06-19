class TrainTypeInApiDecorator < Draper::Decorator
  delegate_all

  def render_name_in_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%p{ class: :text_ja }<
  = this.name_ja_normal
%p{ class: :text_en }<
  = this.name_en_normal
    HAML
  end

  def render_name_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :name_ja_normal }<
  = this.name_ja_normal
    HAML
  end

  def render_in_train_location
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%p{ class: :text_ja }<
  = this.name_ja_normal
%p{ class: :text_en }<
  = this.name_en_normal
    HAML
  end

end

__END__

  def render_in_train_location
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
!= this.name_ja_normal
%span{ class: :text_en }<
  = this.name_en_normal
    HAML
  end
