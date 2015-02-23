module TokyoMetro::Modules::Common::Info::RailwayLine

  def not_branch_railway_line
    !( branch_railway_line )
  end

  def method_missing( method_name , *args )
    if args.empty?
      if /\A((?:is|is_not|not|has)_)?branch(?:_railway)?(?:_line)?(?:\?)?\Z/ =~ method_name.to_s
        valid_method_name = $1.gsub( /is_/ , "" ) + branch_railway_line
        send( valid_method_name )
      end
    end
    super( method_name , *args )
  end

end