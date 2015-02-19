module TokyoMetro::Modules::Api::Convert::Customize::StationFacility::MarunouchiBranchLine::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    convert_platform_infos_related_to_marunouchi_branch_line
  end

  private

  def convert_platform_infos_related_to_marunouchi_branch_line
    case @same_as
    when "odpt.StationFacility:TokyoMetro.NakanoShimbashi" , "odpt.StationFacility:TokyoMetro.NakanoFujimicho" , "odpt.StationFacility:TokyoMetro.Honancho"
      convert_railway_line_name_of_platform_infos_to_marunouchi_branch_line
    end
  end

  def convert_railway_line_name_of_platform_infos_to_marunouchi_branch_line
    infos = @platform_infos.select { | info |
      info.car_composition == 3 and info.railway_line == "odpt.Railway:TokyoMetro.Marunouchi"
    }
    infos.each do | info |
      info.instance_eval do
        @railway_line = "odpt.Railway:TokyoMetro.MarunouchiBranch"
      end
    end
  end

end