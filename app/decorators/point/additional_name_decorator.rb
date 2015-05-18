class Point::AdditionalNameDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- if this.ja.present? and this.en.present?
  %div{ class: [ :additional_info , :text ] }
    %p{ class: :text_ja }<
      = this.ja
    %p{ class: :text_en }<
      = this.en
- elsif this.ja.present?
  %div{ class: [ :additional_info , :text_ja ] }<
    = this.ja
- elsif this.en.present?
  - raise "Error: The variable \'additional_info_en\' is defined but \'additional_info_ja\' is not defined."
    HAML
  end

end
