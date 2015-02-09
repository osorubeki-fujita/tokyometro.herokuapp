module TokyoMetro::Factories::Seed::Api::Point::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 1
    @stations = variables.first
  end

  def optional_variables
    [ @stations ]
  end

end