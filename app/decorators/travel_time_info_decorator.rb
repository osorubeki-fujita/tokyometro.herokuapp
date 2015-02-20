class TravelTimeInfoDecorator < Draper::Decorator
  delegate_all

  extend SubTopTitleRenderer

  def self.sub_top_title_ja
    "停車駅と所要時間のご案内"
  end

  def self.sub_top_title_en
    "Stops and travel time"
  end

  def self.render_empty_row
    h.render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan: 3 }<
    = " "
    HAML
  end

  def self.render_info_between_stations( travel_time_infos , section )
    h_locals = {
      travel_time_infos: travel_time_infos ,
      section: section
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- necessary_time = travel_time_infos.between( *section ).pluck( :necessary_time ).max
= "(" + necessary_time.to_s + ")"
    HAML
  end

  def render_simple_info
    h.render inline: <<-HAML , type: :haml , locals: { travel_time_info: self }
%div{ class: :info }
  = travel_time_info.to_s
    HAML
  end

end