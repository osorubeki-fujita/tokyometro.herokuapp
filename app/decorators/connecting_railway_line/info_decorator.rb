class ConnectingRailwayLine::InfoDecorator < Draper::Decorator
  delegate_all

  decorates_association :railway_line

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

  def url_for_railway_line_page
    unless railway_line_page_exists?
      return nil
    end

    _railway_line_decorated = railway_line_decorated

    if set_anchor_in_travel_time_info_table?
      return h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name , anchor: _railway_line_decorated.travel_time_table_id )
    end

    return h.url_for( controller: :railway_line , action: _railway_line_decorated.railway_line_page_name )
  end

  private

  def railway_line_decorated
    railway_line.decorate
  end

  def railway_line_page_name
    railway_line_decorated.send( __method__ )
  end

  def railway_line_page_exists?
    object.railway_line.tokyo_metro?
  end

  def set_anchor_in_travel_time_info_table?
    object.railway_line.branch_line? or object.station_info.railway_line.branch_railway_line_of?( object.railway_line )
  end

end
