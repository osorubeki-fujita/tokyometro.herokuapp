module TokyoMetro::Modules::Common::Info::RailwayLine::BranchLine

  def branch_railway_line?
    /Branch\Z/ === same_as
  end

  alias :is_branch_railway_line? :branch_railway_line?

end