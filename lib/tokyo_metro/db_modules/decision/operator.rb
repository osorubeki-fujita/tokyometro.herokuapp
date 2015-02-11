module TokyoMetro::DbModules::Decision::Operator

  include ::TokyoMetro::CommonModules::Info::Decision::Operator

  def tokyo_metro?
    operator.tokyo_metro?
  end

end