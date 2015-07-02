module PlatformInfoHelper
end

__END__

  def platform_infos_of_car_compositions( railway_line_name_ja , railway_line_name_en , car_composition_types )

    str = "#{ railway_line_name_ja }の列車は"
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

  def platform_infos_of_each_platform( infos , railway_line_class , car_composition_types , transfer_infos_are_exist , barrier_free_facility_infos_are_exist , surrounding_areas_are_exist )
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
        - method_names = [ :barrier_free_facility_infos , :surrounding_areas , :transfer_infos ]
        - # 車両編成が最長の場合と情報が一致した場合
        - if method_names.all? { | method | compared_info_in_current_composition.send( method ) == compared_info_in_the_longest_composition.send( method ) }
          - 
        - else

        - if compared_info_in_current_composition.barrier_free_facility_infos == compared_info_in_the_longest_composition.barrier_free_facility_infos and 

      - info_sorted_by_car_number.each do | info |
        - compared = info_of_car_composition_max.first
        - if info.barrier_free_facility_infos == info_of_car_composition_max.first.barrier_free_facility_infos and 
        station_facility_platform_info_surrounding_areas
        station_facility_platform_info_transfer_infos