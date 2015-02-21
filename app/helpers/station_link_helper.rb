module StationLinkHelper

  def station_link_matrix_and_lists( make_link_to_line: false )
    render inline: <<-HAML , type: :haml , locals: { make_link_to_line: make_link_to_line }
= station_link_matrix( make_link_to_line )
= station_link_list_ja
= station_link_list_en
    HAML
  end

  def station_link_list_ja
    station_link_list_sub(
      grouping_proc: Proc.new { |h| h[ :name_hira ].first.remove_dakuten } ,
      name_list_in_a_letter_sort_proc: Proc.new { |h| h[ :name_hira ].remove_dakuten } ,
      link_proc: station_link_proc_ja ,
      list_name: :station_list ,
      column_name: :hiragana_column ,
      letter_domain_name: :hiragana
    )
  end

  def station_link_list_en
    station_link_list_sub(
      grouping_proc: Proc.new { |h| h[ :name_en ].first } ,
      name_list_in_a_letter_sort_proc: Proc.new { |h| h[ :name_en ] } ,
      link_proc: station_link_proc_en ,
      list_name: :station_list ,
      column_name: :alphabet_column ,
      letter_domain_name: :alphabet ,
      reverse_array_when_grouping: false
    )
  end

  private

  def station_link_list_sub(
    grouping_proc: nil , name_list_in_a_letter_sort_proc: nil , link_proc: nil ,
    list_name: nil , column_name: nil , letter_domain_name: nil ,
    reverse_array_when_grouping: true
  )
    h_locals = {
      grouped_by_first_letter: @tokyo_metro_station_dictionary_including_main_info.values.group_by { |h| grouping_proc.call(h) } ,
      name_list_in_a_letter_sort_proc: name_list_in_a_letter_sort_proc ,
      link_proc: link_proc ,
      list_name: list_name ,
      column_name: column_name ,
      letter_domain_name: letter_domain_name ,
      tokyo_metro_station_dictionary: @tokyo_metro_station_dictionary ,
      stations_of_railway_lines: @stations_of_railway_lines ,
      reverse_array_when_grouping: reverse_array_when_grouping
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- letters = grouped_by_first_letter.keys.sort
- separation = 3
%div{ id: list_name }
  - slicing_proc = Proc.new { | letters | letters.each_slice( ( letters.length / ( separation * 1.0 ) ).ceil ).to_a }
  - if reverse_array_when_grouping
    - letter_groups = slicing_proc.call( letters.reverse ).reverse.map { |i| i.reverse }
  - else
    - letter_groups = slicing_proc.call( letters )
  - letter_groups.each do | letter_group |
    %div{ class: column_name }
      - letter_group.each do | letter |
        %div{ class: letter_domain_name }
          %h4<
            = letter
          - name_list_in_a_letter = grouped_by_first_letter[ letter ]
          - name_list_in_a_letter.sort_by { | h | name_list_in_a_letter_sort_proc.call(h) }.each do | h |
            %div{ class: :station }<
              = link_proc.call( h , tokyo_metro_station_dictionary )
    HAML
  end

  def station_link_proc_ja
    Proc.new { | station , tokyo_metro_station_dictionary |
      name_ja , name_hira , name_in_system , name_en , station_codes = station_link_set_variables( station )
      # raise "Error: The variable \"name_in_system\" of Station\##{station.id} is nil." if name_in_system.nil?
      name_ja = name_ja.process_specific_letter
      title = [ station_codes_in_title( station_codes ) , "#{ name_ja } - #{ name_hira } (#{ name_en }) " ].join( " " )
      link_to( name_ja , name_in_system.underscore , title: title )
    }
  end

  def station_link_proc_en
    Proc.new { | station , tokyo_metro_station_dictionary |
      name_ja , name_hira , name_in_system , name_en , station_codes = station_link_set_variables( station )
      name_ja = name_ja.process_specific_letter
      title = [ station_codes_in_title( station_codes ) , "#{ name_en } - #{ name_ja } （#{ name_hira }）" ].join( " " )
      link_to( name_en , name_in_system.underscore , title: title )
    }
  end

  def station_codes_in_title( station_codes )
    "\[ #{ station_codes.join(" , " ) } \]"
  end

  def station_link_set_variables( info )
    [ info[ :name_ja ] , info[ :name_hira ] , info[ :name_in_system ] , info[ :name_en ] , info[ :station_codes ] ]
  end

  # 駅一覧表（路線別）を作成
  def station_link_matrix( make_link_to_line )
    h_locals = {
      railway_lines: @railway_lines ,
      stations_of_railway_lines: @stations_of_railway_lines ,
      tokyo_metro_station_dictionary: @tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: @tokyo_metro_station_dictionary_including_main_info ,
      make_link_to_line: make_link_to_line
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :station_matrixes }
  - railway_lines.each do | railway_line |
    %div{ class: :railway_line }
      = railway_line.decorate.render_matrix( make_link_to_line: make_link_to_line , size: :small )
      %div{ class: :stations }
        - if railway_line.same_as == "odpt.Railway:TokyoMetro.Marunouchi"
          = station_link_matrix_of_marunouchi_line( railway_line , stations_of_railway_lines , tokyo_metro_station_dictionary , tokyo_metro_station_dictionary_including_main_info )
        - else
          = station_link_matrix_of_normal_railway_line( railway_line , stations_of_railway_lines , tokyo_metro_station_dictionary , tokyo_metro_station_dictionary_including_main_info )
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def station_link_matrix_of_normal_railway_line(
    railway_line ,
    stations_of_railway_lines ,
    tokyo_metro_station_dictionary ,
    tokyo_metro_station_dictionary_including_main_info
  )
    stations = railway_line.stations
    h_locals = {
      stations: stations.sort_by( &:index_in_railway_line ) ,
      stations_of_railway_lines: stations_of_railway_lines ,
      tokyo_metro_station_dictionary: tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: tokyo_metro_station_dictionary_including_main_info
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- stations.each do | station |
  %div{ class: :station }<
    - station_hash = tokyo_metro_station_dictionary_including_main_info[ station.name_in_system ]
    = station_link_proc_ja.call( station_hash , tokyo_metro_station_dictionary )
    HAML
  end

  # 丸ノ内線（支線を含む）の駅一覧を書き出す
  def station_link_matrix_of_marunouchi_line(
    railway_line ,
    stations_of_railway_lines ,
    tokyo_metro_station_dictionary ,
    tokyo_metro_station_dictionary_including_main_info
  )
    h_locals = {
      railway_line: railway_line ,
      stations_of_railway_lines: stations_of_railway_lines ,
      tokyo_metro_station_dictionary: tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: tokyo_metro_station_dictionary_including_main_info
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_line }
  = station_link_matrix_of_normal_railway_line( railway_line , tokyo_metro_station_dictionary , stations_of_railway_lines , tokyo_metro_station_dictionary_including_main_info )
%div{ class: :branch_line }
  - marunouchi_branch_line = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
  = station_link_matrix_of_normal_railway_line( marunouchi_branch_line , tokyo_metro_station_dictionary , stations_of_railway_lines , tokyo_metro_station_dictionary_including_main_info )
    HAML
  end

end