module StationLinkListHelper

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

end