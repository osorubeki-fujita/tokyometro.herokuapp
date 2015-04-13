class TrainTimetableArrivalInfoDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :arrival_info , :text_en ] }<>
  = info.platform_number_with_parentheses
    HAML
  end

end