class ConnectingRailwayLineDecorator < Draper::Decorator
  delegate_all

  decorates_association :railway_line

  include CssClassNameOfConnectingRailwayLine
  include RenderLinkToRailwayLinePage

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
%div{ class: info.css_class_names }<
  = info.render_link_to_railway_line_page
  = info.railway_line.render_in_station_info_of_travel_time_info
  - if info.connecting_to_another_station?
    = info.connecting_station_info.decorate.render_connection_info_from_another_station
      HAML
    end
  end

  private

  def railway_line_decorated
    railway_line.decorate
  end

  def railway_line_page_exists?
    object.railway_line.tokyo_metro?
  end

  def set_anchor_in_travel_time_info_table?
    object.railway_line.branch_line? or object.station_info.railway_line.branch_railway_line_of?( object.railway_line )
  end

end