module TravelTimeInfoHelper

  def travel_time_info
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :travel_time }
  = travel_time_info_title
  - case railway_lines.length
  - when 1
    - railway_line = railway_lines.first
    - special_proc_of_station = nil
    - special_proc_of_section = nil
    - through_operation_a = nil
    - through_operation_a_info = nil
    - through_operation_b = nil
    - through_operation_b_info = nil
    - #
    - # case railway_line.same_as
    - # when "odpt.Railway:TokyoMetro.Ginza"
    - #  = render "travel_time_info_one_railway_line" , railway_line: railway_line
    - #
    - case railway_line.same_as
    - when "odpt.Railway:TokyoMetro.Hibiya"
      - through_operation_b = travel_time_info_through_operation_h_tobu
      - through_operation_b_info = travel_time_info_through_operation_h_tobu_info
      - #
    - when "odpt.Railway:TokyoMetro.Tozai"
      - special_proc_of_station = travel_time_info_special_proc_of_station_t
      - special_proc_of_section = travel_time_info_special_proc_of_section_t
      - through_operation_a = travel_time_info_through_operation_t_chuo
      - through_operation_a_info = travel_time_info_through_operation_t_chuo_info
      - through_operation_b = travel_time_info_through_operation_t_sobu_toyo
      - through_operation_b_info = travel_time_info_through_operation_t_sobu_toyo_info
      - #
    - when "odpt.Railway:TokyoMetro.Chiyoda"
      - special_proc_of_station = travel_time_info_special_proc_of_station_c
      - special_proc_of_section = travel_time_info_special_proc_of_section_c
      - through_operation_a = travel_time_info_through_operation_c_odakyu
      - through_operation_a_info = travel_time_info_through_operation_c_odakyu_info
      - through_operation_b = travel_time_info_through_operation_c_joban
      - through_operation_b_info = travel_time_info_through_operation_c_joban_info
      - #
    - when "odpt.Railway:TokyoMetro.Yurakucho"
      - special_proc_of_station = travel_time_info_special_proc_of_station_y
      - special_proc_of_section = travel_time_info_special_proc_of_section_y
      - through_operation_a = travel_time_info_through_operation_yf_tobu_seibu
      - through_operation_a_info = travel_time_info_through_operation_yf_tobu_seibu_info
      - #
    - when "odpt.Railway:TokyoMetro.Hanzomon"
      - through_operation_a = travel_time_info_through_operation_z_tokyu
      - through_operation_a_info = travel_time_info_through_operation_z_tokyu_info
      - through_operation_b = travel_time_info_through_operation_z_tobu
      - through_operation_b_info = travel_time_info_through_operation_z_tobu_info
      - #
    - when "odpt.Railway:TokyoMetro.Namboku"
      - special_proc_of_station = travel_time_info_special_proc_of_station_n
      - special_proc_of_section = travel_time_info_special_proc_of_section_n
      - through_operation_a = travel_time_info_through_operation_n_tokyu
      - through_operation_a_info = travel_time_info_through_operation_n_tokyu_info
      - through_operation_b = travel_time_info_through_operation_n_saitama
      - through_operation_b_info = travel_time_info_through_operation_n_saitama_info
      - #
    - when "odpt.Railway:TokyoMetro.Fukutoshin"
      - special_proc_of_station = travel_time_info_special_proc_of_station_f
      - special_proc_of_section = travel_time_info_special_proc_of_section_f
      - through_operation_a = travel_time_info_through_operation_yf_tobu_seibu
      - through_operation_a_info = travel_time_info_through_operation_yf_tobu_seibu_info
      - through_operation_b = travel_time_info_through_operation_f_tokyu_minatomirai
      - through_operation_b_info = travel_time_info_through_operation_f_tokyu_minatomirai_info
      - #
      - #
    = render( "travel_time_info_one_railway_line" , railway_line: railway_line , special_proc_of_station: special_proc_of_station , special_proc_of_section: special_proc_of_section , through_operation_a: through_operation_a , through_operation_a_info: through_operation_a_info , through_operation_b: through_operation_b , through_operation_b_info: through_operation_b_info )
    - #
  - when 2
    - special_proc_of_station = nil
    - special_proc_of_section = nil
    - case railway_lines.map { | railway_line | railway_line.same_as }
    - when [ "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" ]
      = render( "travel_time_info_m" , railway_lines: railway_lines , special_proc_of_station: special_proc_of_station , special_proc_of_section: special_proc_of_section )
    - when [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ]
      = render( "travel_time_info_yf" , railway_lines: railway_lines , special_proc_of_station: special_proc_of_station , special_proc_of_section: special_proc_of_section )
  - else
    - raise "Error"
    HAML
  end

  private

  def travel_time_info_title
    title_of_each_content( "停車駅と所要時間のご案内" , "Stops and travel Time" )
  end

  def travel_time_info_base_one_railway_line( railway_line )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
- railway_line.travel_time_infos.each do | info |
  - from = info.from_station.name_ja
  - to = info.to_station.name_ja
  - t = info.necessary_time
  %div{ class: :info }
    = from + " → " + to + "(" + t.to_s + ")"
    HAML
  end

  def travel_time_info_base_two_railway_lines( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
- railway_lines.each do | railway_line |
  %div{ class: :railway_line }
    = travel_time_info_base_one_railway_line( railway_line )
    HAML
  end

  def travel_time_info_station_name( station )
    connecting_railway_lines = station.connecting_railway_lines.includes( :railway_line , railway_line: :operator )

    if connecting_railway_lines.present?
      if connecting_railway_lines.all?{ | railway_line | railway_line.index_in_station.present? }
        connecting_railway_lines = connecting_railway_lines.order( :index_in_station )
      elsif connecting_railway_lines.all?{ | railway_line | railway_line.index_in_station.nil? }
        connecting_railway_lines = connecting_railway_lines.order( :railway_line_id )
      else
        arr = connecting_railway_lines.map { | connecting_railway_line | [ connecting_railway_line.railway_line.same_as , connecting_railway_line.index_in_station ] }
        raise "Error: #{arr.to_s}"
      end
    end

    render inline: <<-HAML , type: :haml , locals: { station: station , connecting_railway_lines: connecting_railway_lines }
%td{ class: :station_name }
  = link_to( "" , "../station_facility/" + station.name_in_system.underscore , name: station.name_ja + "駅のご案内へジャンプします。" )
  = display_images_of_station_codes( station , false )
  %div{ class: :station }<
    = station_text( station )
%td{ class: :transfer , colspan: 2 }
  - connecting_railway_lines.each do | connecting_railway_line |
    - # 非表示の条件
    - unless connecting_railway_line.railway_line.not_operated_yet?
      = travel_time_info_each_connecting_railway_line( connecting_railway_line )
  HAML
  end

  def travel_time_info_each_connecting_railway_line( connecting_railway_line )
    css_class_name = [ :connecting_railway_line , connecting_railway_line.railway_line.css_class_name ]
    tokyo_metro = connecting_railway_line.railway_line.tokyo_metro?
    if tokyo_metro
      css_class_name << :tokyo_metro
    else
      css_class_name << :other_operators
    end
    if connecting_railway_line.not_recommended
      css_class_name << :not_recommended
    end
    if connecting_railway_line.cleared
      css_class_name << :cleared
    end

    h_locals = {
      connecting_railway_line: connecting_railway_line ,
      css_class_name: css_class_name ,
      tokyo_metro: tokyo_metro
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
- railway_line = connecting_railway_line.railway_line
%div{ class: css_class_name }<
  - if tokyo_metro
    = link_to( "" , "../railway_line/" + railway_line.name_en.gsub( " " , "_" ).underscore )
  = railway_line_code( railway_line , must_display_line_color: true , small: true )
  = railway_line_name_text( railway_line , process_special_railway_line: true )
  - if connecting_railway_line.another_station_id.meaningful?
    - another_station = connecting_railway_line.another_station
    - unless connecting_railway_line.railway_line.same_as == "odpt.Railway:Toei.TodenArakawa"
      - suffix_ja = "駅"
    - else
      - suffix_ja = "停留場"
    %div{ class: :another_station }
      %div{ class: :text_ja }
        = station_name_ja_processing_subname( another_station.name_ja , suffix: suffix_ja )
      %div{ class: :text_en }
        = station_name_en_processing_subname( another_station.name_en , suffix: "Sta." )
    HAML
  end

  def travel_time_info_between_stations( travel_time_infos , section )
    render inline: <<-HAML , type: :haml , locals: { travel_time_infos: travel_time_infos , section: section }
- station_1 = section[0]
- station_2 = section[1]
- travel_time_infos_of_this_section_1 = travel_time_infos.find_by( from_station_id: station_1.id , to_station_id: station_2.id )
- travel_time_infos_of_this_section_2 = travel_time_infos.find_by( from_station_id: station_2.id , to_station_id: station_1.id )
- # raise "Error: " + station_1.same_as + " - " + station_2.same_as + " / " + travel_time_infos_of_this_section_1.to_s + " / " + travel_time_infos_of_this_section_2.to_s
- travel_time = [ travel_time_infos_of_this_section_1 , travel_time_infos_of_this_section_2 ].map { | info | raise "Error: from " + station_1.same_as + " , " + "to " +station_2.same_as if info.nil? ; info.necessary_time }.max
= "(" + travel_time.to_s + ")"
    HAML
  end

  def travel_time_info_square( station )
    render inline: <<-HAML , type: :haml
= " "
    HAML
  end

  def travel_time_info_empty_row
    render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan: 3 }<
    = " "
    HAML
  end

end