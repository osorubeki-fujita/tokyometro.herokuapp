class BarrierFreeFacilityEscalatorDirectionDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { escalator_direction: self }
- # %div{ class: :escalator_directions }<
- #   %div{ class: :escalator_direction }<
- #     = escalator_direction.to_s
- #
%div{ class: :escalator_direction }<
  = escalator_direction.to_s
    HAML
  end

end