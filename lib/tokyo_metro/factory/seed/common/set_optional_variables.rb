module TokyoMetro::Factory::Seed::Common::SetOptionalVariables

  private

  def set_optional_variables( args )
    unless args.empty?
      raise [ "Please over-ride this method \'#{ __method__ }\' in \'#{ self.class }\'." , "The following variable(s) are given." , args.to_s ].join( "\n" )
    end
  end

  def set_optional_variables__check_length_of_args( args , valid_number_of_args )
    unless args.length == valid_number_of_args
      raise [ "Error: The variables \'args\' should contain #{ valid_number_of_args } element(s)." , "The following array you send to this method is not valid." , args.to_s ].join( "\n" )
    end
  end

end