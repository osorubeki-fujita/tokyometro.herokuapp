def connecting_railway_lines
  ::TokyoMetro::Api.stations.each do | station |
    if station.connecting_railway_lines.present?
      connecting_railway_lines__class( station )
      connecting_railway_lines__replacing_railway_lines( station )
      connecting_railway_lines__ignored_railway_lines( station )
      connecting_railway_lines__optional_railway_lines( station )
      connecting_railway_lines__new_railway_lines( station )
      connecting_railway_lines__index_in_stations( station )
      connecting_railway_lines__transfer_additional_infos( station )
    end
  end
end

def connecting_railway_lines__class( station )
  station.connecting_railway_lines.each do | connecting_railway |
    describe ::TokyoMetro::Api::Station::Info , "after setting connecting railway line infos" do
      it "(each connecting railway line info) should be an instance of ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info ." do
        expect( connecting_railway ).to be_instance_of( ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info )
      end
    end
  end
end


def connecting_railway_lines__replacing_railway_lines( station )
  info_related_to_this_station = ::TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.replacing_railway_lines.select { | k , v |
    v[ "stations" ].include?( station.same_as )
  }

  if info_related_to_this_station.present?

    list_of_connecting_railway_lines = get_list_of_connecting_railway_lines( station )

    info_related_to_this_station.each do | invalid_railway_line , info |
      station.connecting_railway_lines.each do | connecting_railway_line_info |
        describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "after replacing railway line names" do
          it "should not be #{invalid_railway_line}." do
            expect( connecting_railway_line_info.railway_line ).not_to eq( invalid_railway_line )
          end
        end
      end

      info[ "replacing_railway_line_names" ].each do | replacing_railway_line_name |
        describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List , "after replacing railway line names" do
          it "should include #{replacing_railway_line_name}." do
            expect( list_of_connecting_railway_lines ).to include( replacing_railway_line_name )
          end
        end
      end
    end

  end
end


def connecting_railway_lines__ignored_railway_lines( station )
  info_related_to_this_station = [ :Customize , :Patches ].map { | namespace |
    eval( "::TokyoMetro::ApiModules::Convert::#{namespace}::Station::ConnectingRailwayLine.ignored_railway_lines" )
  }.flatten.select { | item |
    item[ "stations" ].include?( station.same_as )
  }

  if info_related_to_this_station.present?
    ignored_railway_lines = info_related_to_this_station.map { | item | item[ "railway_lines" ] }.flatten
    list_of_connecting_railway_lines = get_list_of_connecting_railway_lines( station )
    ignored_railway_lines.each do | ignored_railway_line |
      describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "after deleting invalid railway line names" do
        it "(#{station.same_as}) should not be connected to \"#{ignored_railway_line}\"." do
          expect( list_of_connecting_railway_lines ).not_to include( ignored_railway_line )
        end
      end
    end
  end

end


def connecting_railway_lines__optional_railway_lines( station )
  info_related_to_this_station = ::TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.optional_railway_lines.select { | item |
    item[ "stations" ].include?( station.same_as )
  }
  if info_related_to_this_station.present?
    optional_railway_lines = info_related_to_this_station.map { | item | item[ "railway_lines" ] }.flatten
    list_of_connecting_railway_lines = get_list_of_connecting_railway_lines( station )
    optional_railway_lines.each do | optional_railway_line |
      describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "after adding optional railway line" do
        it "(#{station.same_as}) should be connected to \"#{optional_railway_line}\"." do
          expect( list_of_connecting_railway_lines ).to include( optional_railway_line )
        end
      end
    end
  end

end


def connecting_railway_lines__new_railway_lines( station )
  info_related_to_this_station = ::TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.new_railway_lines.select { | new_railway_line_name , info |
    info[ "stations" ].include?( station.same_as )
  }

  if info_related_to_this_station.present?
    info_related_to_this_station.each do | new_railway_line_name , info |

      connecting_railway_line_info_of_this_line = station.connecting_railway_lines.find { | info | info.railway_line == new_railway_line_name }
      describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "after adding new railway line info" do
        it "(#{station.same_as}) should contain the information of \"#{new_railway_line_name}\"." do
          expect( connecting_railway_line_info_of_this_line ).to be_present
        end
      end

      if connecting_railway_line_info_of_this_line.present?
        starting_date_from_yaml = info[ "start_on" ]
        regexp_of_date = /\A(\d{4})\.(\d{2})\.(\d{2})\Z/

        describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "yaml file" do
          it "(#{new_railway_line_name} in #{station.same_as}) should contain valid date info." do
            expect( starting_date_from_yaml ).to be_present
            expect( starting_date_from_yaml ).to match( regexp_of_date )
          end
        end

        if regexp_of_date =~ starting_date_from_yaml
          starting_date = ::DateTime.new( $1.to_i , $2.to_i , $3.to_i )
          describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , "starting date" do
            it "(#{new_railway_line_name} in #{station.same_as}) should start on #{starting_date_from_yaml}." do
              expect( connecting_railway_line_info_of_this_line.start_on ).to eq( starting_date )
            end
          end
        end

      end

    end
  end

end


def connecting_railway_lines__index_in_stations( station )
  info_related_to_this_station = ::TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.index_in_stations[ station.same_as ]
  if info_related_to_this_station.present?

    railway_lines_from_yaml = info_related_to_this_station.keys
    list_of_connecting_railway_lines = get_list_of_connecting_railway_lines( station )
    describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , " - index_in_station" do
      it "(connecting railway lines in \"#{station.same_as}\") should contain the same railway lines in yaml file." do
        expect( railway_lines_from_yaml.sort ).to eq( list_of_connecting_railway_lines.sort )
      end
    end

    station.connecting_railway_lines.each do | connecting_railway_line_info |

      valid_index = info_related_to_this_station[ connecting_railway_line_info.railway_line ][ "index_in_station" ]
      describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , " - index_in_station" do
        it "(\"#{connecting_railway_line_info.railway_line}\" connected at \"#{station.same_as}\") should contain an index number \##{valid_index}." do
          expect( connecting_railway_line_info.index_in_station ).to eq( valid_index )
        end
      end

      if info_related_to_this_station[ connecting_railway_line_info.railway_line ][ "cleared" ]
        describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info , " - cleared" do
          it "(\"#{connecting_railway_line_info.railway_line}\" connected at \"#{station.same_as}\") should be cleared in HTML." do
            expect( connecting_railway_line_info ).to be_cleared
          end
        end
      end

    end

  end
end

def connecting_railway_lines__transfer_additional_infos( station )
  info_related_to_this_station = ::TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.transfer_additional_infos.select { | item |
    item[ "stations" ].include?( station.same_as )
  }
  if info_related_to_this_station.present?
    transfer_additional_infos_in_this_station = get_transfer_additional_infos( info_related_to_this_station )
    station.connecting_railway_lines.each do | connecting_railway_line_info |

      additional_info_of_this_line = transfer_additional_infos_in_this_station[ connecting_railway_line_info.railway_line ]

      if additional_info_of_this_line.present?
        if additional_info_of_this_line[ "not_recommended" ]
          describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info do
            it "(transfer to \"#{connecting_railway_line_info.railway_line}\" at \"#{station.same_as}\") should not be recommend." do
              expect( connecting_railway_line_info ).not_to be_recommended
            end
          end

        end
        if additional_info_of_this_line[ "note" ]
          describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info do
            it "(transfer to \"#{connecting_railway_line_info.railway_line}\" at \"#{station.same_as}\") should contain note." do
              expect( connecting_railway_line_info.note ).to eq( additional_info_of_this_line[ "note" ] )
            end
          end

        end
        if additional_info_of_this_line[ "another_station" ]
          another_station = additional_info_of_this_line[ "another_station" ]
          describe ::TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info do
            it "(\"#{station.same_as}\") should be connected to \"#{ another_station }\" when transfer for \"#{connecting_railway_line_info.railway_line}\"." do
              expect( connecting_railway_line_info.another_station ).to eq( another_station )
            end
          end
          
        end

      end

    end
  end

end


def get_list_of_connecting_railway_lines( station )
  station.connecting_railway_lines.map { | connecting_railway_line_info | connecting_railway_line_info.railway_line }
end


def get_transfer_additional_infos( ary )
  h = ::Hash.new
  ary.each do | item |
    h.update( item[ "railway_lines" ] )
  end
  h
end