module TokyoMetro::Factories::Seed::Api::Fare::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 2
    @normal_fares , @operators = variables
  end

  def optional_variables
    [ @normal_fares , @operators ]
  end

end