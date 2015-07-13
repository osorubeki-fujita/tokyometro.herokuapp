class Train::Timetable::ArrivalInfoDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :arrival_info , :text_en ] }<>
  = this.platform_number_with_parentheses
    HAML
  end

end
