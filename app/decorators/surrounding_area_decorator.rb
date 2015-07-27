class SurroundingAreaDecorator < Draper::Decorator
  delegate_all

  def render
    object.name_ja
  end

end
