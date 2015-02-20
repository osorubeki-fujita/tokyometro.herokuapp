module TwitterHelper

  def twitter_tokyo_metro
    tokyo_metro.decorate.render_twitter_widget
  end

  def twitter_railway_line_info
    if @railway_lines.length == 1 or @railway_lines.map { | railway_line | railway_line.name_code } == [ "M" , "m" ]
      @railway_lines.first.decorate.render_twitter_widget
    else
      @railway_lines.map { | railway_line |
        railway_line.decorate.render_twitter_widget
      }.inject( :+ )
    end
  end

end