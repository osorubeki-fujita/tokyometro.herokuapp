module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::MarunouchiBranchLine::Info

  def initialize( *variables )
    super( *variables )
    convert_station_name_of_marunouchi_branch_line
  end

  private

  def convert_station_name_of_marunouchi_branch_line
    if operated_only_on_marunouchi_branch_line_including_invalid?
      [ :marunouchi_branch_line_stations , :nakano_sakaue ].each do | method |
        replace_station_name( ::TokyoMetro::Modules::Api::Convert::Customize::Dictionary::RegexpForReplace.send( method ) , "MarunouchiBranch" )
      end
    end
  end

end