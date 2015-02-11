module TokyoMetro::CommonModules::Info::RailwayLine

  def branch_line?
    /Branch\Z/ === same_as
  end

  def not_operated_yet?
    same_as == "odpt.Railway:JR-East.UenoTokyo" and ::Time.now <= ::Time.new( 2015 , 3 , 14 , 3 )
  end

  def not_branch_line?
    !( branch_line? )
  end

  def operated_already?
    !( not_operated_yet? )
  end

  alias :already_operated? :operated_already?

end