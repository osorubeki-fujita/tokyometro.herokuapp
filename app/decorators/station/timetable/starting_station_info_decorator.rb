class Station::Timetable::StartingStationInfoDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :starting_station_info }<>
  = this.to_s
    HAML
  end

end
