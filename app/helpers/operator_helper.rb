module OperatorHelper

  def tokyo_metro
    ::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" )
  end

end