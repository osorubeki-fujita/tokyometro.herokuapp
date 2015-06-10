class BarrierFreeFacilityEscalatorDirectionDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: :escalator_direction }<
  = this.to_s
    HAML
  end

end
