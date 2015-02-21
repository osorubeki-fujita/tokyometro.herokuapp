class NormalFareGroupDecorator < Draper::Decorator
  delegate_all

  def render_columns( number_of_stations_in_this_group )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , i_rowspan: number_of_stations_in_this_group }
- info.to_h.each do | class_name , fare |
  %td{ rowspan: i_rowspan , class: class_name }<>
    = number_separated_by_comma( fare )
    HAML
  end

  def to_h
    {
      "ic_card_adult_#{id}" => ic_card_fare ,
      "ic_card_child_#{id}" => child_ic_card_fare ,
      "ticket_adult_#{id}" => ticket_fare ,
      "ticket_child_#{id}" => child_ticket_fare
    }
  end

end