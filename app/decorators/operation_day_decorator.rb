class OperationDayDecorator < Draper::Decorator
  delegate_all

  def render_in_women_only_car_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :title }
  %h4{ class: :text_ja }<
    = info.name_ja
  %h5{ class: :text_en }<
    = info.name_en
    HAML
  end

  def render_in_barrier_free_facility_service_detail_pattern
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :operation_day }<
  = info.name_ja
    HAML
  end

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :operation_day }<
  %div{ class: :text_ja }<
    = info.name_ja
  %div{ class: :text_en }<
    = info.name_en.pluralize
    HAML
  end

end