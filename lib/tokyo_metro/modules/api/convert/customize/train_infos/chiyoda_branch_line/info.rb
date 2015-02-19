module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ChiyodaBranchLine::Info

  def initialize( *variables )
    super( *variables )
    convert_railway_line_name_of_chiyoda_branch_line_train
  end

  private

  def convert_railway_line_name_of_chiyoda_branch_line_train
    if operated_only_on_chiyoda_branch_line_including_invalid?
      regexp_for_replace = ::TokyoMetro::Modules::Api::Convert::Customize::Dictionary::RegexpForReplace.chiyoda_branch_line_stations

      @railway_line = "odpt.Railway:TokyoMetro.ChiyodaBranch"
      @starting_station = @starting_station.gsub( regexp_for_replace , "ChiyodaBranch" )
      @terminal_station = @terminal_station.gsub( regexp_for_replace , "ChiyodaBranch" )
    end
  end

end