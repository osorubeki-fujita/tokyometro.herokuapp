class TravelTimeInfoDecorator < Draper::Decorator
  delegate_all
  
  extend SubTopTitleRenderer
  
  def self.sub_top_title_ja
    "停車駅と所要時間のご案内"
  end
  
  def self.sub_top_title_en
    "Stops and travel time"
  end

  def render_simple_info
    h.render inline: <<-HAML , type: :haml , locals: { travel_time_info: self }
%div{ class: :info }
  = travel_time_info.to_s
    HAML
  end

end