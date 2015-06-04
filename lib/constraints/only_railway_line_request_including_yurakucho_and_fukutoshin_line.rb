class OnlyRailwayLineRequestIncludingYurakuchoAndFukutoshinLine

  def self.matches?( request )
    puts "-" * 4
    puts ::Rails.application.routes.recognize_path( request.referer )
    puts ::Rails.application.routes.recognize_path( request.referer )[ :railway_line ]
    /(?:[a-z]+|yurakucho_and_fukutoshin)_line/ === ::Rails.application.routes.recognize_path( request.referer )[ :railway_line ]
  end

end
