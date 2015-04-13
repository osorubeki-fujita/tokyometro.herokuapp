module TokyoMetro::Factory::Seed::Reference::OperationDay

  private

  def operation_day_ids( *args )
    ::TokyoMetro::Factory::Seed::Static::OperationDay.find_or_create_by_and_get_ids_of( *args )
  end

  def operation_day_id( operation_day_name_en )
    operation_day_ids( operation_day_name_en ).first
  end

end