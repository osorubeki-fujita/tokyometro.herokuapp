class BarrierFreeFacilityToiletAssistantPatternDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { toilet_assistant_info: self }
%div{ class: :toilet_assistants }<
  - ary = toilet_assistant_info.to_a
  - if ary.present?
    - ary.each do | assistant |
      %div{ class: :toilet_assistant }<
        = assistant
    HAML
  end

end