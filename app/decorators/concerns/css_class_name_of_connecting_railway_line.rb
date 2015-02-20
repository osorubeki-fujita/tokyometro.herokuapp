module CssClassNameOfConnectingRailwayLine

  def css_class_name_of_connecting_railway_line
    ary = [ :connecting_railway_line , object.railway_line.css_class_name ]
    if object.railway_line.tokyo_metro?
      ary << :tokyo_metro
    else
      ary << :other_operators
    end
    ary
  end

end