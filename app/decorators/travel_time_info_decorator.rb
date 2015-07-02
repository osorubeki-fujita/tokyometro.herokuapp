class TravelTimeInfoDecorator < Draper::Decorator
  delegate_all

  def self.render_empty_row
    h.render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan: 3 }<
    = " "
    HAML
  end

  def render_simple_info
    h.render inline: <<-HAML , type: :haml , locals: { travel_time_info: self }
%div{ class: :info }
  = travel_time_info.to_s
    HAML
  end

end
