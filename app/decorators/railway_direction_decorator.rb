class RailwayDirectionDecorator < Draper::Decorator
  delegate_all
  decorates_association :station_info

  def in_document
    ::RailwayDirectionDecorator::InDocument.new( self )
  end

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :direction }<
  = info.station_info.render_direction_in_station_timetable_header
    HAML
  end

  def render_in_station_facility_platform_info_transfer_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :railway_direction }
  %p{ class: :text_ja }<
    = this.station_info.decorate.render_name_ja( with_subname: false , suffix: "方面" )
  %p{ class: :text_en }<
    = this.station_info.decorate.render_name_en( with_subname: false , prefix: "for " )
    HAML
  end

  def render_simple_title
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- station_info = info.station_info.decorate
%div{ class: :title_of_a_railway_direction }
  %h4{ class: :text_ja }<
    = station_info.name_ja_actual + "方面"
  %h5{ class: :text_en }<
    = "for " + station_info.name_en
    HAML
  end

  alias :render_title_in_train_location :render_simple_title

end
