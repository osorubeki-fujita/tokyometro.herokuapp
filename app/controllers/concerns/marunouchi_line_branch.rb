module MarunouchiLineBranch

  def marunouchi_line
    each_railway_line( "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" )
  end

end