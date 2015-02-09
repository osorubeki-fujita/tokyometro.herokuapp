module TokyoMetro::Factories::Seed::Api::PassengerSurvey::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @operators = variables.first
  end

  def optional_variables
    [ @operators ]
  end

end