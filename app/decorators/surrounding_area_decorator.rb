class SurroundingAreaDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.name
    HAML
  end

end