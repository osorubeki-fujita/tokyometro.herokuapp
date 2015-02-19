# @note
#   This module is prepended
#     to {TokyoMetro::Api::Station::Info}
#     by {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info

  # Constructor
  # @note
  #   This method uses {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info#convert_and_delete_connecting_railway_line_names} .
  # @note
  #   {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info} is included
  #     to {TokyoMetro::Api::Station::Info}
  #     by {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
  def initialize( *variables )
    super( *variables )
    convert_and_delete_connecting_railway_line_names(
      replacing: ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.replacing_railway_lines ,
      ignored: ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.ignored_railway_lines
    )
    add_optional_railway_lines
    add_new_railway_lines
    set_index_in_station
    set_transfer_additional_infos
  end

  private

  def add_optional_railway_lines
    optional_railway_lines = ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.optional_railway_lines.select { | item |
      item[ "stations" ].include?( @same_as )
    }

    if optional_railway_lines.present?
      set_new_connecting_railway_line_list_unless_exist
      optional_railway_lines.each do | item |
        item[ "railway_lines" ].each do | railway_line |
          @connecting_railway_lines << self.class.connecting_railway_line_info_class.new( railway_line )
        end
      end
    end

  end

  def add_new_railway_lines
    new_railway_lines = ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.new_railway_lines.select { | new_railway_line_name , info |
      info[ "stations" ].include?( @same_as )
    }

    if new_railway_lines.present?
      set_new_connecting_railway_line_list_unless_exist
      new_railway_lines.each do | new_railway_line_name , info |
        @connecting_railway_lines << self.class.connecting_railway_line_info_class.new( new_railway_line_name , start_on: info[ "start_on" ] )
      end
    end

  end

  def set_index_in_station
    index_info_in_this_station = ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.index_in_stations[ @same_as ]
    if index_info_in_this_station.present?
      @connecting_railway_lines.each do | connecting_railway_line_info |
        index_info_of_this_railway_line = index_info_in_this_station[ connecting_railway_line_info.railway_line ]
        if index_info_of_this_railway_line.nil?
          raise "Error: index of #{ connecting_railway_info.railway_line } in \"#{@same_as}\" is not defined."
        end

        connecting_railway_line_info.send( :set_index_in_station , index_info_of_this_railway_line[ "index_in_station" ] )
        if index_info_of_this_railway_line[ "cleared" ]
          connecting_railway_line_info.send( :set_cleared )
        end

      end

      @connecting_railway_lines.sort!
    else
      @connecting_railway_lines.try( :set_index_in_station! )
    end

  end

  def set_transfer_additional_infos
    _transfer_additional_infos_of_this_station = transfer_additional_infos_of_this_station

    if _transfer_additional_infos_of_this_station.present?
      @connecting_railway_lines.each do | connecting_railway_line_info |
        additional_info_of_this_railway_line = _transfer_additional_infos_of_this_station[ connecting_railway_line_info.railway_line ]

        if additional_info_of_this_railway_line.present?
          settings = [
            [ :connecting_another_station , true ] ,
            [ :not_recommended , false ] ,
            [ :note , true ]
          ]
          settings.each do | key_of_h , require_h_setting |
            set_specific_transfer_additional_info( connecting_railway_line_info , additional_info_of_this_railway_line , key_of_h , require_h_info: require_h_setting )
          end
        end

      end
    end

  end

  def set_specific_transfer_additional_info( connecting_railway_line_info , additional_info_of_this_railway_line , key_of_h , require_h_info: false )
    if additional_info_of_this_railway_line[ key_of_h.to_s ].present?
      variables = ::Array.new
      variables << "set_#{key_of_h}"
      if require_h_info
        variables <<  additional_info_of_this_railway_line[ key_of_h.to_s ]
      end
      connecting_railway_line_info.send( *variables )
    end
  end

  def set_new_connecting_railway_line_list_unless_exist
    unless @connecting_railway_lines.present?
      @connecting_railway_lines = self.class.connecting_railway_line_list_class.new
    end
  end

  def transfer_additional_infos_of_this_station
    ary = ::TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.transfer_additional_infos.select { | item |
      item[ "stations" ].include?( @same_as )
    }
    if ary.present?
      h = ::Hash.new
      ary.each do | item |
        h.update( item[ "railway_lines" ] )
      end
      h
    else
      nil
    end
  end

end