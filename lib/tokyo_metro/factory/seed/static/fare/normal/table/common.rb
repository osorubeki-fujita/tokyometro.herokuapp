module TokyoMetro::Factory::Seed::Static::Fare::Normal::Table::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 2 )
    @date_of_revision , @operator_id = args
  end

  def optional_variables
    [ @date_of_revision , @operator_id ]
  end

end