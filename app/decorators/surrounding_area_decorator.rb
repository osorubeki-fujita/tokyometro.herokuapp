class SurroundingAreaDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.name_ja
    HAML
  end

end
