module TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::ChiyodaBranchLine::Info

  # Constructor
  # @note {::TokyoMetro::Api::StationTimetable::Info#.initialize} に機能を追加する。
  # @return [::TokyoMetro::Api::StationTimetable::Info]
  def initialize( *variables )
    super( *variables )
    convert_infos_related_to_chiyoda_branch_line
  end

  private

  # @note @railway_line を "odpt.Railway:TokyoMetro.ChiyodaBranchLine" で統一する。
  def convert_infos_related_to_chiyoda_branch_line
    regexp = /(?<=\Aodpt\.StationTimetable\:TokyoMetro\.)Chiyoda(?=\.(?:KitaAyase\.Ayase|Ayase\.KitaAyase)\Z)/
    if same_as?( regexp )
      @same_as = @same_as.gsub( regexp , "ChiyodaBranch" )

      class << @fundamental_infos
        include ::TokyoMetro::Refinement::Api::StationTimetable::Info::Fundamental::List
      end

      @fundamental_infos.convert_railway_lines!( /(?<=\Aodpt\.Railway\:TokyoMetro\.)Chiyoda(?:Branch)?\Z/ , "ChiyodaBranch" )
      @fundamental_infos.convert_stations!( /(?<=\Aodpt\.Station\:TokyoMetro\.)Chiyoda(?:Branch)?(?=\.(?:Kita)?Ayase\Z)/ , "ChiyodaBranch" )
    end
  end

end