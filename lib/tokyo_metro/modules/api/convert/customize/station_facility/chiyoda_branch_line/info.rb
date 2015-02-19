module TokyoMetro::Modules::Api::Convert::Customize::StationFacility::ChiyodaBranchLine::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    convert_platform_infos_related_to_chiyoda_branch_line
  end

  private

  def convert_platform_infos_related_to_chiyoda_branch_line
    case @same_as
    when "odpt.StationFacility:TokyoMetro.Ayase"
      convert_railway_line_name_of_platform_infos_to_chiyoda_branch_line
      convert_railway_line_name_of_transfer_infos_to_chiyoda_branch_line

    when "odpt.StationFacility:TokyoMetro.KitaAyase"
      convert_railway_line_name_of_platform_infos_to_chiyoda_branch_line
    end
  end

  def convert_railway_line_name_of_platform_infos_to_chiyoda_branch_line
    infos = @platform_infos.select { | info |
      info.car_composition == 3 and info.railway_line == "odpt.Railway:TokyoMetro.Chiyoda"
    }
    infos.each do | info |
      info.instance_eval do
        @railway_line = "odpt.Railway:TokyoMetro.ChiyodaBranch"
      end
    end
  end

  def convert_railway_line_name_of_transfer_infos_to_chiyoda_branch_line
    infos = @platform_infos.each do | platform_info |
      if platform_info.transfer_infos.present?

        platform_info.transfer_infos.each do | transfer_info |
          if transfer_info.railway_line == "odpt.Railway:TokyoMetro.Chiyoda" and transfer_info.railway_direction == "odpt.RailDirection:TokyoMetro.KitaAyase"
            transfer_info.instance_eval do
              @railway_line = "odpt.Railway:TokyoMetro.ChiyodaBranch"
            end
          end
        end

      end
    end
  end

end