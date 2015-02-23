module PassengerSurveyHelper

  def passenger_survey_stations_displayed( stations )
    if @railway_lines_including_branch.blank?
      @railway_lines_including_branch = ::RailwayLine.tokyo_metro( including_branch_line: true )
    end

    stations_displayed = stations.in_railway_line( @railway_lines_including_branch.map( &:id ).flatten )
    if stations_displayed.all?( &:at_ayase? )
      stations_displayed = [ stations_displayed.first ]
    end
    stations_displayed
  end

end