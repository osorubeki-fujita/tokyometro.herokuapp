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
    - case railway_line.same_as
    - when "odpt.Railway:TokyoMetro.Hibiya"
      - through_operation_b = travel_time_info_through_operation_h_tobu
      - through_operation_b_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_hibiya_line_and_tobu_line
      - #
    - when "odpt.Railway:TokyoMetro.Tozai"
      - special_proc_of_station = travel_time_info_special_proc_of_station_tozai_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_tozai_b
      - through_operation_a = travel_time_info_through_operation_t_chuo
      - through_operation_a_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_tozai_line_and_jr_chuo_line
      - through_operation_b = travel_time_info_through_operation_t_sobu_toyo
      - through_operation_b_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_tozai_line_jr_sobu_line_and_toyo_rapid_railway_line
      - #
    - when "odpt.Railway:TokyoMetro.Yurakucho"
      - special_proc_of_station = travel_time_info_special_proc_of_station_yurakucho_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_yurakucho_b
      - through_operation_a = travel_time_info_through_operation_yf_tobu_seibu
      - through_operation_a_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_yurakucho_line_tobu_tojo_line_and_seibu_ikebukuro_line
      - #
    - when "odpt.Railway:TokyoMetro.Hanzomon"
      - through_operation_a = travel_time_info_through_operation_z_tokyu
      - through_operation_a_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_hanzomon_line_and_tokyu_den_en_toshi_line
      - through_operation_b = travel_time_info_through_operation_z_tobu
      - through_operation_b_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_hanzomon_line_and_tobu_line
      - #
    - when "odpt.Railway:TokyoMetro.Namboku"
      - special_proc_of_station = travel_time_info_special_proc_of_station_namboku_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_namboku_b
      - through_operation_a = travel_time_info_through_operation_n_tokyu
      - through_operation_a_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_namboku_line_and_tokyu_meguro_line
      - through_operation_b = travel_time_info_through_operation_n_saitama
      - through_operation_b_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_namboku_line_and_saitama_railway_line
      - #
    - when "odpt.Railway:TokyoMetro.Fukutoshin"
      - special_proc_of_station = travel_time_info_special_proc_of_station_fukutoshin_a
      - special_proc_of_section = travel_time_info_special_proc_of_section_fukutoshin_b
      - through_operation_a = travel_time_info_through_operation_yf_tobu_seibu
      - through_operation_a_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line
      - through_operation_b = travel_time_info_through_operation_f_tokyu_minatomirai
      - through_operation_b_info = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_fukutoshin_line_and_tokyu_toyoko_mm_line
      - #
    :ruby
      h = {
        railway_line: railway_line ,
        special_proc_of_station: special_proc_of_station ,
        special_proc_of_section: special_proc_of_section ,
        through_operation_a: through_operation_a ,
        through_operation_a_info: through_operation_a_info ,
        through_operation_b: through_operation_b ,
        through_operation_b_info: through_operation_b_info
      }
    - # 各線の所要時間情報
    - # @note 一般的な分岐などがない路線で用いる部分テンプレート
    - # @note 部分テンプレート travel_time_info_common を内部で呼び出す。
    = render( "travel_time_info_common" , h )
    - #
  - when 2
    :ruby
      h = {
        railway_lines: railway_lines ,
        special_proc_of_station_1: nil ,
        special_proc_of_section_1: nil ,
        through_operation_1a: nil ,
        through_operation_1a_info: nil ,
        through_operation_1b: nil ,
        through_operation_1b_info: nil ,
        special_proc_of_station_2: nil ,
        special_proc_of_section_2: nil ,
        through_operation_2a: nil ,
        through_operation_2a_info: nil ,
        through_operation_2b: nil ,
        through_operation_2b_info: nil ,
        class_name_of_domain_1: :travel_time_info_main ,
        class_name_of_domain_2: :travel_time_info_branch ,
      }

    - case railway_lines.map( &:same_as )
    - when [ "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" ]
      :ruby
        h[ :class_name_of_whole_domain ] = :marunouchi_main_and_branch_travel_time
        
    - when [ "odpt.Railway:TokyoMetro.Chiyoda" , "odpt.Railway:TokyoMetro.ChiyodaBranch" ]
      :ruby
        h[ :class_name_of_whole_domain ] = :chiyoda_main_and_branch_travel_time
        h[ :special_proc_of_station_1 ] = travel_time_info_special_proc_of_station_chiyoda_a
        h[ :special_proc_of_section_1 ] = travel_time_info_special_proc_of_section_chiyoda_b
        h[ :through_operation_1a ] = travel_time_info_through_operation_c_odakyu
        h[ :through_operation_1a_info ] = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_chiyoda_line_and_odakyu_line
        h[ :through_operation_1b ] = travel_time_info_through_operation_c_joban
        h[ :through_operation_1b_info ] = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_chiyoda_line_and_jr_joban_line
    - when [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ]
      :ruby
        h[ :class_name_of_whole_domain ] = :yurakucho_and_fukutoshin_travel_time
        h[ :class_name_of_domain_1 ] = :yurakucho ,
        h[ :class_name_of_domain_2 ] = :fukutoshin
        h[ :special_proc_of_station_1 ] = travel_time_info_special_proc_of_station_yurakucho_a
        h[ :special_proc_of_section_1 ] = travel_time_info_special_proc_of_section_yurakucho_b
        h[ :through_operation_1a ] = travel_time_info_through_operation_yf_tobu_seibu
        h[ :through_operation_1a_info ] = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_yurakucho_line_tobu_tojo_line_and_seibu_ikebukuro_line
        h[ :special_proc_of_station_2 ] = travel_time_info_special_proc_of_station_fukutoshin_a
        h[ :special_proc_of_section_2 ] = travel_time_info_special_proc_of_section_fukutoshin_b
        h[ :through_operation_2a ] = travel_time_info_through_operation_yf_tobu_seibu
        h[ :through_operation_2a_info ] = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line
        h[ :through_operation_2b ] = travel_time_info_through_operation_f_tokyu_minatomirai
        h[ :through_operation_2b_info ] = ::TravelTimeInfoDecorator.proc_for_rendering_through_operation_info_of_fukutoshin_line_and_tokyu_toyoko_mm_line
    = render( "travel_time_info_of_multiple_railway_lines" , h )
  - else
    - raise "Error"
    HAML
  end

  def travel_time_info_special_proc_of_station_tozai_a
    nil
  end

  def travel_time_info_special_proc_of_section_tozai_b
    nil
  end

  def travel_time_info_special_proc_of_station_chiyoda_a
    nil
  end

  def travel_time_info_special_proc_of_section_chiyoda_b
    nil
  end

  def travel_time_info_special_proc_of_station_yurakucho_a
    nil
  end

  def travel_time_info_special_proc_of_section_yurakucho_b
    nil
  end

  def travel_time_info_special_proc_of_station_namboku_a
    nil
  end

  def travel_time_info_special_proc_of_section_namboku_b
    nil
  end

  def travel_time_info_special_proc_of_station_fukutoshin_a
    nil
  end

  def travel_time_info_special_proc_of_section_fukutoshin_b
    nil
  end

  def travel_time_info_through_operation_h_tobu
    nil
  end

  def travel_time_info_through_operation_t_chuo
    nil
  end

  def travel_time_info_through_operation_t_sobu_toyo
    nil
  end

  def travel_time_info_through_operation_c_odakyu
    nil
  end

  def travel_time_info_through_operation_c_joban
    nil
  end

  def travel_time_info_through_operation_z_tokyu
    nil
  end

  def travel_time_info_through_operation_z_tobu
    nil
  end

  def travel_time_info_through_operation_n_tokyu
    nil
  end

  def travel_time_info_through_operation_n_saitama
    nil
  end

  def travel_time_info_through_operation_yf_tobu_seibu
    nil
  end

  def travel_time_info_through_operation_f_tokyu_minatomirai
    nil
  end

end