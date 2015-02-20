module TokyoMetro::Modules::Common::Info::RailwayLine

  def branch_line?
    /Branch\Z/ === same_as
  end

  def not_branch_line?
    !( branch_line? )
  end

  [ :branch_line? , :not_branch_line? ].each do | method_base_name |
    eval <<-ALIAS
      alias :is_#{ method_base_name } :#{ method_base_name }
    ALIAS
  end

end