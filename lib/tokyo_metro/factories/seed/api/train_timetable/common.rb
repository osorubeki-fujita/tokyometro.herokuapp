module TokyoMetro::Factories::Seed::Api::TrainTimetable::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 5
    @operators , @railway_lines , @stations , @railway_directions , @train_owners = variables
  end

  def optional_variables
    [ @operators , @railway_lines , @stations , @railway_directions , @train_owners ]
  end

end