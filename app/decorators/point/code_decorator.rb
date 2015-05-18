class Point::CodeDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- if this.has_additional_name?
  %div{ class: :code }
    %div{ class: [ :main , :text_en ] }<
      = this.main_to_s
    - if this.has_additional_name?
      = this.additional_name.decorate.render
- else
  = this.main_to_s
    HAML
  end

end
