module TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::ChiyodaBranchLine::Info

  def initialize( *variables )
    super( *variables )
    convert_station_name_of_chiyoda_branch_line
  end

  private

  def convert_station_name_of_chiyoda_branch_line
    if operated_only_on_chiyoda_branch_line_including_invalid?
      replace_station_name( ::TokyoMetro::ApiModules::Convert::Customize::Dictionary::RegexpForReplace.chiyoda_branch_line_stations , "ChiyodaBranch" )
    end
  end

end