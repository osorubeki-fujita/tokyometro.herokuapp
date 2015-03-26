class WomenOnlyCarInfoDecorator < Draper::Decorator
  delegate_all

  extend SubTopTitleRenderer

  def self.sub_top_title_ja
    "女性専用車のご案内"
  end

  def self.sub_top_title_en
    "Women only car"
  end
  
  def self.render_infos_in_a_railway_line( infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: infos }
- infos.group_by( &:operation_day_id ).each do | operation_day_id , group_by_operation_day_id |
  %div{ class: :operation_day }<
    = ::OperationDay.find( operation_day_id ).decorate.render_in_women_only_car_info
    - group_by_operation_day_id.group_by( &:from_station_info_id ).each do | from_station_info_id , group_by_from_station_info_id |
      - group_by_from_station_info_id.group_by( &:to_station_info_id ).each do | to_station_info_id , group_by_from_and_to_station_info_id |
        %div{ class: :section }
          = group_by_from_and_to_station_info_id.first.decorate.render_title_of_section
          - group_by_from_and_to_station_info_id.group_by( &:available_time_to_s ).each do | available_time , group_by_available_time |
            %div{ class: :section_infos }
              %div{ class: [ :available_time , :text_en ] }<
                = available_time
              %div{ class: :infos }
                - group_by_available_time.each do | info |
                  = info.decorate.render_place
    HAML
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