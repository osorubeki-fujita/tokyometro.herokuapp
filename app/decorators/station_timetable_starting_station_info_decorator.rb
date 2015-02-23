class StationTimetableStartingStationInfoDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :starting_station }<>
  = info.to_s
    HAML
  end

end