module StationInfoHelper

  def stations_displayed_in_passenger_survey_table_row( stations )
    if @railway_lines_including_branch.blank?
      @railway_lines_including_branch = ::RailwayLine.tokyo_metro( including_branch_line: true )
    end

    stations_displayed = stations.in_railway_line( @railway_lines_including_branch.map( &:id ).flatten )
    if stations_displayed.all?( &:at_ayase? )
      stations_displayed = [ stations_displayed.first ]
    end
    stations_displayed
  end

  def station_link_matrix_and_lists( make_link_to_railway_line: false , type_of_link_to_station: nil )
    h_locals = {
      make_link_to_railway_line: make_link_to_railway_line ,
      type_of_link_to_station: type_of_link_to_station
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
= station_link_matrix( make_link_to_railway_line , type_of_link_to_station )
- # = station_link_list_ja
- # = station_link_list_en
    HAML
  end

  # 駅一覧表（路線別）を作成
  def station_link_matrix( make_link_to_railway_line , type_of_link_to_station )
    h_locals = {
      railway_lines: @railway_lines.select_not_branch_line ,
      make_link_to_railway_line: make_link_to_railway_line ,
      type_of_link_to_station: type_of_link_to_station
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
= select_station_from_railway_line
%div{ id: :station_matrixes }
  - railway_lines.each do | railway_line |
    = railway_line.decorate.render_matrix_and_links_to_stations( make_link_to_railway_line , type_of_link_to_station )
    HAML
  end

  def station_link_list_ja
    station_link_list_ja_or_en(
      grouping_proc: ::Proc.new { | station | station.name_hira.first.remove_dakuten } ,
      name_list_in_a_letter_sort_proc: ::Proc.new { | station | station.name_hira.remove_dakuten } ,
      link_proc: ::Proc.new { | station | station.decorate.render_link_to_station_page_ja } ,
      list_name: :station_list ,
      column_name: :hiragana_column ,
      letter_domain_name: :hiragana
    )
  end

  def station_link_list_en
    station_link_list_ja_or_en(
      grouping_proc: ::Proc.new { | station | station.name_en.first } ,
      name_list_in_a_letter_sort_proc: ::Proc.new { | station | station.name_en } ,
      link_proc: ::Proc.new { | station | station.decorate.render_link_to_station_page_en } ,
      list_name: :station_list ,
      column_name: :alphabet_column ,
      letter_domain_name: :alphabet ,
      reverse_array_when_grouping: false
    )
  end

  private

  def station_link_list_ja_or_en(
    grouping_proc: nil ,
    name_list_in_a_letter_sort_proc: nil ,
    link_proc: nil ,
    list_name: nil ,
    column_name: nil ,
    letter_domain_name: nil ,
    reverse_array_when_grouping: true
  )
    raise "Error" unless [ grouping_proc , name_list_in_a_letter_sort_proc , link_proc , list_name , column_name , letter_domain_name ].all?( &:present? )
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
  - slicing_proc = ::Proc.new { | letters | letters.each_slice( ( letters.length / ( separation * 1.0 ) ).ceil ).to_a }
  - if reverse_array_when_grouping
    - letter_groups = slicing_proc.call( letters.reverse ).reverse.map( &:reverse )
  - else
    - letter_groups = slicing_proc.call( letters )
  - letter_groups.each do | letter_group |
    %div{ class: column_name }
      - letter_group.each do | letter |
        %div{ class: letter_domain_name }
          %h4<
            = letter
          - name_list_in_a_letter = grouped_by_first_letter[ letter ]
          - name_list_in_a_letter.sort_by { | h | name_list_in_a_letter_sort_proc.call(h) }.each do | station |
            %div{ class: :station }<
              = link_proc.call( station )
    HAML
  end

end