module PlatformInfoHelper

  def platform_infos_of_railway_lines
    platform_infos_grouped_by_railway_line = @station_facility.platform_infos_including_other_infos_grouped_by_railway_line_id

    class << platform_infos_grouped_by_railway_line
      include ::ForRails::PlatformInfosOfMultipleLine
    end

    # 有楽町線・副都心線の共用区間の場合
    if platform_infos_grouped_by_railway_line.platform_infos_of_yurakucho_and_fukutoshin_line?( @station_facility )
      railway_line_ids = platform_infos_grouped_by_railway_line.keys.sort
      local_h = { railway_line_ids: railway_line_ids , platform_infos_grouped_by_railway_line: platform_infos_grouped_by_railway_line }

      render inline: <<-HAML , type: :haml , locals: local_h
%div{ id: :platform_info_tab_menu }
  = platform_infos_tabs( railway_line_ids , yf: true )
  %div{ id: :platform_info_tab_contents }
    %ul
      - railway_line_id = railway_line_ids.first
      - platform_infos_of_this_line = platform_infos_grouped_by_railway_line[ railway_line_id ]
      = platform_infos_of_each_railway_line( railway_line_id , platform_infos_of_this_line , yf: true )
      HAML

    # 南北線・三田線の共用区間の場合
    elsif platform_infos_grouped_by_railway_line.platform_infos_of_namboku_and_toei_mita_line?( @station_facility )
      railway_line_ids = [ "odpt.Railway:TokyoMetro.Namboku" , "odpt.Railway:Toei.Mita" ].map { | item | ::RailwayLine.find_by_same_as( item ).id }
      local_h = { railway_line_ids: railway_line_ids , platform_infos_grouped_by_railway_line: platform_infos_grouped_by_railway_line }

      render inline: <<-HAML , type: :haml , locals: local_h
%div{ id: :platform_info_tab_menu }
  = platform_infos_tabs( railway_line_ids , ni: true )
  %div{ id: :platform_info_tab_contents }
    %ul
      - railway_line_id = railway_line_ids.first
      - platform_infos_of_this_line = platform_infos_grouped_by_railway_line[ railway_line_id ]
      = platform_infos_of_each_railway_line( railway_line_id , platform_infos_of_this_line , ni: true )
      HAML

    # 一般の場合
    else
      railway_line_ids = platform_infos_grouped_by_railway_line.keys.sort
      local_h = { railway_line_ids: railway_line_ids , platform_infos_grouped_by_railway_line: platform_infos_grouped_by_railway_line }

      render inline: <<-HAML , type: :haml , locals: local_h
%div{ id: :platform_info_tab_menu }
  = platform_infos_tabs( railway_line_ids )
  %div{ id: :platform_info_tab_contents }
    %ul
      - railway_line_ids.each do | railway_line_id |
        - platform_infos_of_this_line = platform_infos_grouped_by_railway_line[ railway_line_id ]
        = platform_infos_of_each_railway_line( railway_line_id , platform_infos_of_this_line )
      HAML

    end
  end

  private

  def platform_infos_of_each_railway_line( railway_line_id , infos_of_each_railway_line , yf: false , ni: false )
    raise "Error" if yf and ni

    if yf
      railway_line_name_ja = "有楽町線・副都心線"
      railway_line_name_en = "Yurakucho and Fukutoshin Line"
      railway_line_class = :yurakucho_and_fukutoshin
      railway_line_tab_name = :platform_info_yurakucho_and_fukutoshin_line
    elsif ni
      railway_line_name_ja = "南北線・都営三田線"
      railway_line_name_en = "Namboku and Toei Mita Line"
      railway_line_class = :namboku_and_toei_mita
      railway_line_tab_name = :platform_info_namboku_and_toei_mita_line

    else
      railway_line = ::RailwayLine.find( railway_line_id )

      railway_line_name_ja = railway_line.name_ja
      railway_line_name_en = railway_line.name_en
      railway_line_class = railway_line.css_class_name
      railway_line_tab_name = "platform_info_" + railway_line.css_class_name
    end

    render_settings = {
      railway_line_name_ja: railway_line_name_ja ,
      railway_line_name_en: railway_line_name_en ,
      railway_line_class: railway_line_class ,
      railway_line_tab_name: railway_line_tab_name ,
      platform_infos_of_each_railway_line: infos_of_each_railway_line ,
      car_composition_types: infos_of_each_railway_line.map( &:car_composition ).uniq ,
      direction_types_are_exist: infos_of_each_railway_line.any? { | info | info.railway_direction_id.present? } ,
      yf: yf ,
      ni: ni
    }

    render inline: <<-HAML , type: :haml , locals: render_settings
%li{ id: railway_line_tab_name , name: railway_line_tab_name , class: :platform_info_tab_content }
  %div{ class: railway_line_class }
    %div{ class: :title_of_railway_line }
      %h3{ class: :text_ja }<
        = railway_line_name_ja
      %h4{ class: :text_en }<
        = railway_line_name_en
  - if direction_types_are_exist
    - platform_infos_of_each_railway_line_grouped_by_direction = platform_infos_of_each_railway_line.group_by( &:railway_direction_id )
    - platform_infos_of_each_railway_line_grouped_by_direction.each do | railway_direction_id , infos |
      = platform_infos_of_each_direction( railway_direction_id , railway_line_class , car_composition_types , infos , yf: yf , ni: ni )
  - else
    = platform_infos_of_each_platform( railway_line_class , car_composition_types , infos , transfer_infos_are_exist , barrier_free_facilities_are_exist , surrounding_areas_are_exist )
    HAML

  end

  def platform_infos_of_car_compositions( railway_line_name_ja , railway_line_name_en , car_composition_types )

    str = "#{railway_line_name_ja}の列車は"
    case car_composition_types.length
    when 1
      str += "すべて#{car_composition_types.first}両編成です。"
    when 2
      car_compositions = car_composition_types.map { | car_composition | "#{car_composition}両編成" }.join( "または" )
      str += "#{car_compositions}です。"
    else
      arr_of_car_compositions = car_composition_types.map { | car_composition | "#{car_composition}両編成" }
      car_compositions = arr_of_car_compositions[0..-2].join( "、" ) + "または" + arr_of_car_compositions[-1]
      str += "#{car_compositions}です。"
    end

    render inline: <<-HAML , type: :haml , locals: { str: str }
%div{ class: :info_of_car_compositons }
  = str
    HAML

  end

  def platform_infos_of_each_direction( railway_direction_id , railway_line_class , car_composition_types , infos , yf: false , ni: false )

    transfer_infos_are_exist = infos.any? { | info | info.station_facility_platform_info_transfer_infos.present? }
    barrier_free_facilities_are_exist = infos.any? { | info | info.barrier_free_facilities.present? }
    surrounding_areas_are_exist = infos.any? { | info | info.surrounding_areas.present? }

    if transfer_infos_are_exist or barrier_free_facilities_are_exist or surrounding_areas_are_exist

      direction = ::RailwayDirection.find( railway_direction_id ).station

      hash_of_locals = {
        direction: direction ,
        car_composition_types: car_composition_types ,
        railway_line_class: railway_line_class ,
        infos: infos ,
        transfer_infos_are_exist: transfer_infos_are_exist ,
        barrier_free_facilities_are_exist: barrier_free_facilities_are_exist ,
        surrounding_areas_are_exist: surrounding_areas_are_exist ,
        yf: yf ,
        ni: ni
      }

      render inline: <<-HAML , type: :haml , locals: hash_of_locals
- platform_str_ja_base = "方面行きホーム"
- platform_str_en_base = "Platform for "
- platform_str_ja = String.new
- platform_str_en = String.new

%div{ class: :info_of_railway_direction }
  %div{ class: :title_of_direction }<
    %h4{ class: :text_ja }<>
      - if yf and direction.name_ja == "新木場"
        = "池袋・"
        - platform_str_en += "Ikebukuro, "
        %span{ class: :railway_line_name }<>
          ="有楽町線"
        = "新木場・"
        - platform_str_en += "Shin-kiba (Yurakucho Line) and "
        %span{ class: :railway_line_name }<>
          = "副都心線"
        = "渋谷" + platform_str_ja
        - platform_str_en += "Shibuya (Fukutoshin Line)"
      - elsif ni and direction.name_ja == "赤羽岩淵"
        %span{ class: :railway_line_name }<>
          ="南北線"
        = "赤羽岩淵・"
        - platform_str_en += "Akabane-iwabuchi (Namboku Line) and "
        %span{ class: :railway_line_name }<>
          = "都営三田線"
        = "西高島平" + platform_str_ja_base
        - platform_str_en += "Nishi-takashimadaira (Toei Mita Line)"
      - else
        = direction.decorate.render_name_ja( with_subname: true , suffix: platform_str_ja_base )
        - platform_str_en += direction.name_en
    %h5{ class: :text_en }<>
      = ( platform_str_en_base + platform_str_en )
  = platform_infos_of_each_platform( railway_line_class , car_composition_types , infos , transfer_infos_are_exist , barrier_free_facilities_are_exist , surrounding_areas_are_exist )
    HAML

    end
  end

  def platform_infos_of_each_platform( railway_line_class , car_composition_types , infos , transfer_infos_are_exist , barrier_free_facilities_are_exist , surrounding_areas_are_exist )
    case car_composition_types.length
    when 1
      h_locals = {
        railway_line_class: railway_line_class ,
        info_sorted_by_car_number: infos.sort_by( &:car_number ) ,
        transfer_infos_are_exist: transfer_infos_are_exist ,
        barrier_free_facilities_are_exist: barrier_free_facilities_are_exist ,
        surrounding_areas_are_exist: surrounding_areas_are_exist
      }
      platform_infos_of_each_platform_sub( h_locals )

    # 車両編成の種類が複数の場合（有楽町線・副都心線）
    else
      infos_grouped_by_car_composition = infos.group_by( &:car_composition )
      h_locals = { infos_grouped_by_car_composition: infos_grouped_by_car_composition }
      render inline: <<-HAML , type: :haml , locals: h_locals
- car_composition_array = infos_grouped_by_car_composition.keys
- car_composition_max = car_composition_array.max
- info_of_car_composition_max = infos_grouped_by_car_composition[ car_composition_max ].sort_by( &:car_number )
- # 最長ではない車両編成を取得
- car_composition_without_max = ( car_composition_array - [ car_composition_max ] ).sort.reverse

%table
  - # 車両編成が最長の場合の処理
  %tr{ class: :car_composition_max }
    %td{ class: :car_composition_info }
      = "#{car_composition_max}両編成"
    = platform_infos_car_number_array( info_of_car_composition_max )
  - # -------- 車両編成が最長以外の場合の処理
  - # それぞれの編成数の場合を処理する
  - car_composition_without_max.each | composition | do
    - first_blank = 0 # platform_infos_of_multiple_car_composition_first_blank( infos_grouped_by_car_composition , car_composition )
    %tr{ class: :car_composition_normal }
      %td{ class: :car_composition_info }
        = "#{composition}両編成"
      - first_blank.times do
        %td{ class: :empty }
      = platform_infos_car_number_array( info_of_this_car_composition )
      - ( car_composition_max - car_composition - first_blank ).times do
        %td{ class: :empty }
      HAML
    end
  end

  def platform_infos_of_each_platform_sub( h_locals )
    render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: :platform_info }
  = platform_infos_car_number_array( railway_line_class , info_sorted_by_car_number )
  - # 乗換路線がある場合は、乗換の情報を記述
  - if transfer_infos_are_exist
    = platform_infos_transfer_info_array( info_sorted_by_car_number )
  - # 駅構内の施設がある場合は、駅構内の施設の情報を記述
  - if barrier_free_facilities_are_exist
    = platform_infos_barrier_free_info_array( info_sorted_by_car_number )
  - # 駅周辺の情報がある場合は、駅周辺の情報を記述
  - if surrounding_areas_are_exist
    = platform_infos_surrounding_area_info_array( info_sorted_by_car_number )
    HAML
  end

  def platform_infos_car_number_array( railway_line_class , infos )
    render inline: <<-HAML , type: :haml , locals: { railway_line_class: railway_line_class , infos: infos }
%tr{ class: [ railway_line_class , :car_numbers , :text_en ] }
  = ::StationFacilityPlatformInfoDecorator.render_an_empty_cell
  - infos.each do | info |
    %td{ class: :car_number }<
      = info.car_number
    HAML
  end

  def platform_infos_transfer_info_array( infos )
    h_locals = {
      infos_of_transfer_infos: infos.map( &:station_facility_platform_info_transfer_infos ) ,
      proc_for_display: ::Proc.new { | info | info.decorate.render } ,
      proc_for_decision: ::Proc.new { | infos | infos.map( &:to_array_of_displayed_infos ) }
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: :transfer_infos }
  = ::StationFacilityPlatformInfoDecorator.render_transfer_info_title
  - concat platform_infos_conncet_cells_including_same_info_and_make_cells( infos_of_transfer_infos , proc_for_display , proc_for_decision )
    HAML
  end

  def platform_infos_barrier_free_info_array( infos )
    infos_of_barrier_free_facilities = infos.map { | info | info.barrier_free_facilities.includes( :barrier_free_facility_located_area , :barrier_free_facility_type , :barrier_free_facility_service_details ) }
    h_locals = {
      infos_of_barrier_free_facilities_inside: infos_of_barrier_free_facilities.map { | info_of_each_car |
        info_of_each_car.select( &:inside? )
      } ,
      infos_of_barrier_free_facilities_outside: infos_of_barrier_free_facilities.map { | info_of_each_car |
        info_of_each_car.select( &:outside? )
      } ,
      proc_for_display_inside: Proc.new { | info |
        id_and_code = info.decorate.id_and_code_hash
        link_to( id_and_code[ :platform ] , url_for( anchor: id_and_code[ :id ] ) )
      } ,
      proc_for_display_outside: Proc.new { | info |
        id_and_code = info.decorate.id_and_code_hash
        link_to( id_and_code[ :platform ] , url_for( anchor: id_and_code[ :id ] ) )
      }
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- if infos_of_barrier_free_facilities_inside.any?( &:present? )
  %tr{ class: :barrier_free_infos_inside }
    = ::StationFacilityPlatformInfoDecorator.render_inside_barrier_free_facility_title
    - concat platform_infos_conncet_cells_including_same_info_and_make_cells( infos_of_barrier_free_facilities_inside , proc_for_display_inside )

- if infos_of_barrier_free_facilities_outside.any?( &:present? )
  %tr{ class: :barrier_free_infos_outside }
    = ::StationFacilityPlatformInfoDecorator.render_outside_barrier_free_facility_title
    - concat platform_infos_conncet_cells_including_same_info_and_make_cells( infos_of_barrier_free_facilities_outside , proc_for_display_outside )
    HAML
  end

  def platform_infos_surrounding_area_info_array( infos )
    h_locals = {
      infos_of_surrounding_areas: infos.map( &:surrounding_areas ) ,
      proc_for_display: ::Proc.new { | info | info.decorate.render }
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: :surrounding_areas }
  = ::StationFacilityPlatformInfoDecorator.render_surrounding_area_info_title
  - concat platform_infos_conncet_cells_including_same_info_and_make_cells( infos_of_surrounding_areas , proc_for_display )
    HAML
  end

  # 乗車位置情報のタブを作成
  def platform_infos_tabs( railway_line_ids , yf: false , ni: false )
    raise "Error" if yf and ni

    if yf or ni
      if yf
        tab_name = @default_platform_info_tab
        railway_line_name_ja = "有楽町線・副都心線"
        railway_line_name_en = "Yurakucho and Fukutoshin Line"
      elsif ni
        tab_name = @default_platform_info_tab
        div_class_name = :namboku_and_toei_mita
        railway_line_name_ja = "南北線・都営三田線"
        railway_line_name_en = "Namboku and Toei Mita Line"
      end

      h_locals = {
        railway_line_ids: railway_line_ids ,
        tab_name: tab_name ,
        railway_line_name_ja: railway_line_name_ja ,
        railway_line_name_en: railway_line_name_en
      }
      render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :platform_info_tabs }
  %ul
    %li{ class: [ tab_name , :platform_info_tab ] }<
      = ::StationFacilityPlatformInfoDecorator.render_link_in_tab( tab_name )
      %div{ class: :railway_line_name }
        - railway_line_ids.each do | railway_line_id |
          - railway_line_instance = ::RailwayLine.find( railway_line_id ).decorate
          %div{ class: railway_line_instance.css_class_name }
            = railway_line_instance.render_railway_line_code( small: true )
        %div{ class: :text }<
          %div{ class: :text_ja }<
            = railway_line_name_ja
          %div{ class: :text_en }<
            = railway_line_name_en
      HAML

    else

      render inline: <<-HAML , type: :haml , locals: { railway_line_ids: railway_line_ids }
%div{ id: :platform_info_tabs }
  %ul
    - railway_line_ids.sort.each do | railway_line_id |
      = ::RailwayLine.find( railway_line_id ).decorate.render_station_facility_platform_info_transfer_info
      HAML
    end

  end

  def platform_infos_conncet_cells_including_same_info_and_make_cells( infos , proc_for_display , proc_for_dicision = nil )
    if proc_for_dicision.nil?
      proc_for_dicision = ::Proc.new { | infos | infos.map( &:id ) }
    end

    i = 0
    while i <= infos.length - 1 do
      info_in_this_cell = infos[i]
      if info_in_this_cell.blank?
        concat ::StationFacilityPlatformInfoDecorator.render_an_empty_cell
        i += 1
      else
        connected_cells = platform_infos_number_of_connected_cells( infos , i , proc_for_dicision )
        concat platform_infos_make_a_cell_including_same_info( info_in_this_cell , connected_cells , proc_for_display )
        i += connected_cells
      end
    end
  end

  # 結合する cell の個数を取得するメソッド
  def platform_infos_number_of_connected_cells( infos , i , proc_for_dicision )
    i_next = 1
    i_compared = i + i_next

    while platform_infos_equal_to_next_cell?( infos , i , i_compared , proc_for_dicision )
      i_next += 1
      i_compared = i + i_next
    end

    i_next
  end

  # 次のセルと内容が同一か否かを判定するメソッド
  # @note #platform_infos_number_of_connected_cells から呼び出す
  def platform_infos_equal_to_next_cell?( infos , i , i_compared , proc_for_dicision )
    info_in_i = infos[ i ]
    info_compared = infos[ i_compared ]
    last_index = infos.length - 1
    if i < last_index and info_compared.present?
      proc_for_dicision.call( info_in_i ) == proc_for_dicision.call( info_compared )
    else
      false
    end
  end

  # 中身のあるセルを作成するメソッド
  def platform_infos_make_a_cell_including_same_info( info_in_this_cell , connected_cells , proc_for_display )
    h_locals = { infos: info_in_this_cell , connected_cells: connected_cells , proc_for_display: proc_for_display }
    render inline: <<-HAML , type: :haml , locals: h_locals
- if connected_cells == 1
  %td{ class: :present }<
    = platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
- else
  %td{ class: :present , colspan: connected_cells }<
    = platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
    HAML
  end

  # 中身のあるセルの具体的な中身を記述するメソッド
  def platform_infos_make_content_in_a_cell_including_same_info( infos , proc_for_display )
    render inline: <<-HAML , type: :haml , locals: { infos: infos , proc_for_display: proc_for_display }
%ul
  - infos.each do | info |
    %li<
      = proc_for_display.call( info )
    HAML
  end

end

__END__

  # 複数の車両編成数がある場合の処理
  def platform_infos_of_multiple_car_composition_first_blank( infos_grouped_by_car_composition , car_composition )
    car_composition_array = car_composition_types.keys
    car_composition_max = car_composition_array.max


    - ( car_composition_array - [ car_composition_max ] ).each do | car_composition |
      - info_of_this_car_composition = infos_grouped_by_car_composition[ car_composition ]
      - info_sorted_by_car_number = info_of_this_car_composition.sort_by( &:car_number )
      - car_number_of_in_the_longest_composition = 1
      - while car_number_of_in_the_longest_composition <= info_of_car_composition_max
        - compared_info_in_the_longest_composition = info_of_car_composition_max.select { | info | info.car_numeber == car_number_of_in_the_longest_composition }
        - raise "Error" if compared_info_in_the_longest_composition.length == 1
        - compared_info_in_current_composition = info_sorted_by_car_number.first
        - method_names = [ :barrier_free_facilities , :surrounding_areas , :transfer_infos ]
        - # 車両編成が最長の場合と情報が一致した場合
        - if method_names.all? { | method | compared_info_in_current_composition.send( method ) == compared_info_in_the_longest_composition.send( method ) }
          - 
        - else

        - if compared_info_in_current_composition.barrier_free_facilities == compared_info_in_the_longest_composition.barrier_free_facilities and 

      - info_sorted_by_car_number.each do | info |
        - compared = info_of_car_composition_max.first
        - if info.barrier_free_facilities == info_of_car_composition_max.first.barrier_free_facilities and 
        station_facility_platform_info_surrounding_areas
        station_facility_platform_info_transfer_infos