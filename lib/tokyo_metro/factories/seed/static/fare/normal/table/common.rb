module TokyoMetro::Factories::Seed::Static::Fare::Normal::Table::Common

  private

  def set_optional_variables( args )
    raise "Error" unless args.length == 2
    @date_of_revision , @operator_id = args
  end

  def optional_variables
    [ @date_of_revision , @operator_id ]
  end

end