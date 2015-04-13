class TokyoMetro::App::Renderer::StationLinkList::English < TokyoMetro::App::Renderer::StationLinkList::MetaClass

  private

  def stations_grouped_by_first_letter
    @stations.values.group_by { | station |
      station[ :name_en ].first
    }
  end

  def proc_for_sorting_name_list_in_a_letter_category
    ::Proc.new { | station | station[ :name_en ] }
  end

  def proc_for_render_link
    ::Proc.new { | station |
      ::Station::Info.find_by( name_in_system: station[ :name_in_system ] ).decorate.render_link_to_station_page_en
    }
  end

  def domain_id
    :station_link_list_en
  end

  def domain_class_name_of_column
    [ :alphabet_column , :text_en ]
  end

  def domain_class_name_of_each_letter
    :alphabet
  end

  def groups_of_letters
    # letters = stations_grouped_by_first_letter.keys.sort
    # number_of_columns = 3
    # columns = letters.each_slice( ( letters.length / ( number_of_columns * 1.0 ) ).ceil ).to_a
    # columns
    [ "abcdefghij" , "klmnopqr" , "stuvwxyz" ].map { | str | str.upcase.split( // ) }
  end

end