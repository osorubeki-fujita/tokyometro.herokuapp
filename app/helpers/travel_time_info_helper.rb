module TravelTimeInfoHelper

  def render_travel_time_info
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :travel_time }
  = ::TravelTimeInfoDecorator.render_sub_top_title
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
      - special_proc_of_station = travel_time_info_special_proc_of_station_tozai_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_tozai_b
      - through_operation_a = travel_time_info_through_operation_t_chuo
      - through_operation_a_info = travel_time_info_through_operation_t_chuo_info
      - through_operation_b = travel_time_info_through_operation_t_sobu_toyo
      - through_operation_b_info = travel_time_info_through_operation_t_sobu_toyo_info
      - #
    - when "odpt.Railway:TokyoMetro.Chiyoda"
      - special_proc_of_station = travel_time_info_special_proc_of_station_chiyoda_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_chiyoda_b
      - through_operation_a = travel_time_info_through_operation_c_odakyu
      - through_operation_a_info = travel_time_info_through_operation_c_odakyu_info
      - through_operation_b = travel_time_info_through_operation_c_joban
      - through_operation_b_info = travel_time_info_through_operation_c_joban_info
      - #
    - when "odpt.Railway:TokyoMetro.Yurakucho"
      - special_proc_of_station = travel_time_info_special_proc_of_station_yurakucho_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_yurakucho_b
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
      - special_proc_of_station = travel_time_info_special_proc_of_station_namboku_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_namboku_b
      - through_operation_a = travel_time_info_through_operation_n_tokyu
      - through_operation_a_info = travel_time_info_through_operation_n_tokyu_info
      - through_operation_b = travel_time_info_through_operation_n_saitama
      - through_operation_b_info = travel_time_info_through_operation_n_saitama_info
      - #
    - when "odpt.Railway:TokyoMetro.Fukutoshin"
      - special_proc_of_station = travel_time_info_special_proc_of_station_fukutoshin_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_fukutoshin_b
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
    - case railway_lines.map( &:same_as )
    - when [ "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" ]
      = render( "travel_time_info_m" , railway_lines: railway_lines , special_proc_of_station: special_proc_of_station , special_proc_of_section: special_proc_of_section )
    - when [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ]
      = render( "travel_time_info_yf" , railway_lines: railway_lines , special_proc_of_station: special_proc_of_station , special_proc_of_section: special_proc_of_section )
  - else
    - raise "Error"
    HAML
  end

  private

  def travel_time_info_station_name( station )
    connecting_railway_lines = station.connecting_railway_lines.includes( :railway_line , railway_line: :operator )

    if connecting_railway_lines.present?
      if connecting_railway_lines.all?( &:has_index_in_station? )
        connecting_railway_lines = connecting_railway_lines.order( :index_in_station )
      elsif connecting_railway_lines.all?( &:not_have_index_in_station? )
        connecting_railway_lines = connecting_railway_lines.order( :railway_line_id )
      else
        ary = connecting_railway_lines.map { | connecting_railway_line | [ connecting_railway_line.railway_line.same_as , connecting_railway_line.index_in_station ] }
        raise "Error: #{ary.to_s}"
      end
    end

    render inline: <<-HAML , type: :haml , locals: { station: station.decorate , connecting_railway_lines: connecting_railway_lines }
%td{ class: :station_name }
  = link_to( "" , "../station_facility/" + station.name_in_system.underscore , name: station.name_ja + "駅のご案内へジャンプします。" )
  = station.render_station_code_image( all: false )
  %div{ class: :station }<
    = station.render_name_ja_and_en
%td{ class: :transfer , colspan: 2 }
  - connecting_railway_lines.each do | connecting_railway_line |
    = connecting_railway_line.decorate.render
  HAML
  end

  def travel_time_info_square( station )
    render inline: <<-HAML , type: :haml
= " "
    HAML
  end

end