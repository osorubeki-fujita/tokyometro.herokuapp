module ChiyodaLineBranch

  def chiyoda_line
    each_railway_line( "odpt.Railway:TokyoMetro.Chiyoda" , "odpt.Railway:TokyoMetro.ChiyodaBranch" )
  end

end