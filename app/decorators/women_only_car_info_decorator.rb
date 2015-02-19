class WomenOnlyCarInfoDecorator < Draper::Decorator
  delegate_all
  
  extend SubTopTitleRenderer
  
  def self.sub_top_title_ja
    "女性専用車のご案内"
  end
  
  def self.sub_top_title_en
    "Women only car"
  end
  
  def car_composition_ja_precise
    "#{ object.car_composition }両編成"
  end
  
  def car_number_ja_precise
    "#{ object.car_number }号車"
  end
  
  def place_to_s_ja
    "#{ car_composition_ja_precise }の#{ car_number_ja_precise }"
  end
  
  def section_to_s_ja
    object.section.map( &:name_ja ).join( " → " )
  end
  
  def section_to_s_en
    "from #{from_station_name_en} to #{to_station_name_en}"
  end
  
  def available_time_from_ja
    "#{ object.available_time_from }から"
  end
  
  def available_time_from_en
    "from #{ object.available_time_from }"
  end
  
  def available_time_until_ja
    "#{ object.available_time_until }まで"
  end
  
  def available_time_until_en
    "until #{ object.available_time_until }"
  end
  
  def render_title_of_section
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :title }
  %h5{ class: :text_ja }<
    = info.section_to_s_ja
  %h6{ class: :text_en }<
    = info.section_to_s_en
    HAML
  end
  
  def render_place
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :info }<
  %div{ class: :place }<
    %span{ class: :text_en }<>
      = info.car_composition
    = "両編成の"
    %span{ class: :text_en }<>
      = info.car_number
    = "号車"
  %div{ class: :cars }
    - ( 1..( info.car_composition ) ).each do | car |
      - if car == info.car_number
        - div_classes = [ :car , :text_en , :women_only ]
      - else
        - div_classes = [ :car , :text_en , :normal ]
      %div{ class: div_classes }<
        = car
    HAML
  end

end