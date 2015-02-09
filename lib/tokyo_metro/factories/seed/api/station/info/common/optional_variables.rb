module TokyoMetro::Factories::Seed::Api::Station::Info::Common::OptionalVariables

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @station_id = variables.first
  end

  def optional_variables
    [ @station_id ]
  end

end