module TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::OperationDay

  private

  # @!group 運行日に関するメソッド

  def operated_on_holiday?
    [ "Holiday" , "Saturday and Holiday" ].include?( @operation_day_in_db.name_en )
  end

  # @!endgroup

end