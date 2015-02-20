class SurroundingAreaDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :surrounding_area }<
  = info.name
    HAML
  end

end