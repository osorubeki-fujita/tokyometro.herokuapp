class OnlyRailwayLineRequestConstraint

  def initialize
  end

  def matches?( request )
    puts "-" * 4
    puts ::Rails.application.routes.recognize_path( request.referer )
    puts ::Rails.application.routes.recognize_path( request.referer )[ :railway_line ]
    /[a-z]+_line/ === ::Rails.application.routes.recognize_path( request.referer )[ :railway_line ]
  end

end
