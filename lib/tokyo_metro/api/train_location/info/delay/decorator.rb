class TokyoMetro::Api::TrainLocation::Info::Delay::Decorator < TokyoMetro::Api::MetaClass::RealTime::Info::Decorator

  def displayed_in_train_information?
    object.displayed_in_train_information?
  end

  def render_in_location_of_each_train
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :delay }
  %div{ class: :title_of_delay }
    %p{ class: :text_ja }<>
      = "遅れ"
      %span{ class: :small }<
        = "（分：秒）"
    %p{ class: :text_en }<>
      = "Delay"
      %span{ class: :small }<
        = "(mm:ss)"
  %div{ class: [ :time , :text_en ] }<
    = this.object.to_s_separated_by_comma
    HAML
  end

  def render_ja_in_train_information
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%p{ class: :max_delay }<
  = "現在の遅れ 最大 " + this.object.to_s_ja
    HAML
  end

  def render_en_in_train_information
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%p{ class: :max_delay }<
  = "Max delay: " + this.object.to_s_en
    HAML
  end

  def render_in_train_information_precise_version
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :max_delay }<
  = "最大遅れ：" + this.object.delay.to_s + "秒"
    HAML
  end

end