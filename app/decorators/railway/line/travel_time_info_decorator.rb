class Railway::Line::TravelTimeInfoDecorator < Draper::Decorator
  delegate_all

  def self.render_empty_row
    h.render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan: 3 }<
    = " "
    HAML
  end

  def render_simple_info
    h.content_tag( :div , object.to_s , class: :info )
  end

end
