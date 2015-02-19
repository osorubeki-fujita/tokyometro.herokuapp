class StationDecorator < Draper::Decorator

  delegate_all
  
  include SubTopTitleRenderer

  def render_connection_info_from_another_station
    h.render inline: <<-HAML , type: :haml , locals: { station: self }
%div{ class: :another_station }
  %div{ class: :text_ja }
    = station_name_ja_processing_subname( station.name_ja , suffix: station.attribute_ja )
  %div{ class: :text_en }
    = station_name_en_processing_subname( station.name_en , suffix: station.attribute_en )
    HAML
  end
  
  def render_fare_title_of_this_station
    render_sub_top_title( text_ja: "#{ name_ja }駅から・までの運賃" , text_en: "Fares from/to #{ name_en } station" )
  end
  
  def render_direction_in_station_timetable_header
    render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :direction }<
  %div{ class: :text_ja }<
    = info.name_ja + "方面"
  %div{ class: :text_en }<
    = "for " + info.name_en
    HAML
  end

end