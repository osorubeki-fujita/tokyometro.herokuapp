module ForRails::WomenOnlyCarInfos

  def have_only_one_railway_line?
    self.pluck( :railway_line_id ).uniq.length == 1
  end

  def only_one_railway_line
    if have_only_one_railway_line?
      ::RailwayLine.find( self.pluck( :railway_line_id ).first )
    else
      raise "Error"
    end
  end

  def infos_of_the_only_one_railway_line
    if have_only_one_railway_line?
      self
    else
      raise "Error"
    end
  end

  alias :of_the_only_one_railway_line :infos_of_the_only_one_railway_line

end