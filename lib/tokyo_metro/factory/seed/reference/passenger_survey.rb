module TokyoMetro::Factory::Seed::Reference::PassengerSurvey

  private

  def passenger_survey_in_db( whole = nil , search_by: @info.survey )
    if whole.present?
      whole.find_by_same_as( search_by )
    else
      ::PassengerSurvey.find_by_same_as( search_by )
    end
  end

  def passenger_survey_id( whole = nil , search_by: @info.survey )
    _passenger_survey_in_db = passenger_survey_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _passenger_survey_in_db.nil?
    _passenger_survey_in_db.id
  end

end