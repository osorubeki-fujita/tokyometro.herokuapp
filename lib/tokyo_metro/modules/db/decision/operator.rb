module TokyoMetro::Modules::Db::Decision::Operator

  include ::TokyoMetro::Modules::Common::Info::Decision::Operator

  def tokyo_metro?
    operator.tokyo_metro?
  end

end