module TokyoMetro::CommonModules::Info::Decision::Operator

  def operated_by_tokyo_metro?
    @operator == "odpt.Operator:TokyoMetro"
  end

end