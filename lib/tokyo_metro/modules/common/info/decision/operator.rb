module TokyoMetro::Modules::Common::Info::Decision::Operator

  def tokyo_metro?
    operator == "odpt.Operator:TokyoMetro"
  end

  def operated_by_tokyo_metro?
    tokyo_metro?
  end

  [ :tokyo_metro? , :operated_by_tokyo_metro? ].each do | method_base_name |
    eval <<-DEF
      def not_#{ method_base_name }
        !( #{ method_base_name } )
      end
    DEF
  end

end