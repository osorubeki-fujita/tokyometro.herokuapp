module RailwayLineByParams

  private

  def railway_line_by_params( param_key = :railway_line , branch_railway_line_info: nil , use_station_info: false , yurakucho_and_fukutoshin: false )
    raise "Error" unless [ :exclude , :main_and_branch , :convert_to_main , :no_process ].include?( branch_railway_line_info )

    if yurakucho_and_fukutoshin and params[ param_key ] == "yurakucho_and_fukutoshin_line"
      return ::Railway::Line::Info.tokyo_metro.where( same_as: [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ] )
    end

    if params[ param_key ].blank? and use_station_info
      r = @station_info.railway_line
    else
      railway_line_name_base_by_params = params[ param_key ].gsub( /_line\Z/ , "" )
      railway_line_name_same_as = "odpt.Railway:TokyoMetro.#{ railway_line_name_base_by_params.camelize }"
      r = ::Railway::Line::Info.tokyo_metro.find_by( same_as: railway_line_name_same_as )
      if r.blank?
        raise "Error: \"#{ railway_line_name_same_as }\" is not valid as a railway line name."
      end
    end

    unless r.is_branch_railway_line_info? or r.has_branch_railway_line_info?
      return r
    end

    if r.is_branch_railway_line_info?
      case branch_railway_line_info
      when :exclude
        nil
      when :main_and_branch
        ::Railway::Line::Info.where( id: [ r.id , r.main_railway_line_info_id ].sort )
      when :convert_to_main
        r.main_railway_line_info
      when :no_process
        r
      end

    elsif r.has_branch_railway_line_info?
      case branch_railway_line_info
      when :exclude , :no_process , :convert_to_main
        r
      when :main_and_branch
        ::Railway::Line::Info.where( id: [ r.id , r.branch_railway_line_info_id ].sort )
      end
    end
  end

end
