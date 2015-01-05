module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::OperationDay

  private

  # @!group 運行日に関するメソッド

  def operated_on_holiday?
    [ "Holiday" , "Saturday and Holiday" ].include?( @operation_day_instance.name_en )
  end
  
  # @!endgroup

end