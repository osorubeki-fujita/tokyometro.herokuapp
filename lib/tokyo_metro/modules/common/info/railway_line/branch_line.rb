module TokyoMetro::Modules::Common::Info::RailwayLine::BranchLine

  def branch_railway_line
    /Branch\Z/ === same_as
  end

end