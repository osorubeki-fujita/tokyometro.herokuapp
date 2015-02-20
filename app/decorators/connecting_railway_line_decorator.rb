class ConnectingRailwayLineDecorator < Draper::Decorator
  delegate_all

  decorates_association :railway_line
  
  include CssClassNameOfConnectingRailwayLine
  
  def self.render_title_of_tokyo_metro_railway_lines_in_station_facility_info
    h.render inline: <<-HAML , type: :haml
%div{ class: :title }
  %div{ class: :text_ja }<
    = "東京メトロの路線"
  %div{ class: :text_en }<
    = "Railway lines of Tokyo Metro"
    HAML
  end
  
  def self.render_title_of_other_railway_lines_in_station_facility_info
    h.render inline: <<-HAML , type: :haml
%div{ class: :title }
  %div{ class: :text_ja }<
    = "乗り入れ路線"
  %div{ class: :text_en }<
    = "Other railway lines"
    HAML
  end

  def css_class_name_of_connecting_railway_line
    ary = super
    if not_recommended?
      ary << :not_recommended
    end
    if cleared?
      ary << :cleared
    end
    ary
  end
  
  alias :css_class_names :css_class_name_of_connecting_railway_line

  def render
    unless object.railway_line.not_operated_yet?
      h_locals = {
        info: self
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
- railway_line = info.railway_line
%div{ class: info.css_class_names }<
  = info.railway_line.render_in_station_info_of_travel_time_info
  - if info.connecting_to_another_station?
    = info.connecting_station.decorate.render_connection_info_from_another_station
      HAML
    end
  end

end