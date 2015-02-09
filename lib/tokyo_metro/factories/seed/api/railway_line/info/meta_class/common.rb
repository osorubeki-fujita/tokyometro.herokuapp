module TokyoMetro::Factories::Seed::Api::RailwayLine::Info::MetaClass::Common

  def set_optional_variables( variables )
    raise "Error: #{variables.to_s}" unless variables.length == 1
    @railway_line_id = variables.first
  end

  def optional_variables
    [ @railway_line_id ]
  end

end