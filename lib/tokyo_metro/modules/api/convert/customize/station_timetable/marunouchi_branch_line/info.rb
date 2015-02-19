
__END__

module TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::MarunouchiBranchLine::Info

  # Constructor
  # @note {::TokyoMetro::Api::StationTimetable::Info#.initialize} に機能を追加する。
  # @return [::TokyoMetro::Api::StationTimetable::Info]
  def initialize( *variables )
    super( *variables )
    convert_infos_related_to_marunouchi_branch_line
  end

  private

  # @note @railway_line は、方南町、中野富士見町、中野新橋、中野坂上を "odpt.Railway:TokyoMetro.MarunouchiBranch" で統一する。
  def convert_infos_related_to_marunouchi_branch_line
    if same_as?( /\Aodpt\.StationTimetable\:TokyoMetro\.MarunouchiBranch/ )
      @railway_line = "odpt.Railway:TokyoMetro.MarunouchiBranch"
    end
  end

end