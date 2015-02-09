module TokyoMetro::Factories::Seed::Common::SetOptionalVariables

  private

  def set_optional_variables( variables )
    unless variables.empty?
      raise [ "Please over-ride this method \'#{ __method__ }\' in \'#{ self.class }\'." , "The following variable(s) are given." , variables.to_s ].join( "\n" )
    end
  end

end