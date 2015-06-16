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
%li{ class: :operation_day }<
  %p{ class: :text_ja }<
    = info.name_ja
  %p{ class: :text_en }<
    = info.name_en
    HAML
  end

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :operation_day }<
  %p{ class: :text_ja }<
    = info.name_ja
  %p{ class: :text_en }<
    = info.name_en.pluralize
    HAML
  end

  def css_class_name
    name_en.downcase.gsub( / / , "_" )
  end

end