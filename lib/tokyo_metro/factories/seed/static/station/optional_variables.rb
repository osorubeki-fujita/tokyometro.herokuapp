module TokyoMetro::Factories::Seed::Static::Station::OptionalVariables

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @railway_line_id = variables.first
  end

end