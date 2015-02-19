module TokyoMetro::Modules::Api::Convert::Customize::Station::StationCodeOfNakanoSakaueOnMarunouchiBranchLine::Info

  def initialize( *variables )
    super( *variables )
    convert_station_code_of_nakano_sakaue_on_marunouchi_branch_line
  end

  private

  def convert_station_code_of_nakano_sakaue_on_marunouchi_branch_line
    case @same_as
    when "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"
      @station_code = "m06"
    end
  end

end