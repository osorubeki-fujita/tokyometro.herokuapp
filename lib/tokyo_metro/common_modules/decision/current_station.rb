module TokyoMetro::CommonModules::Decision::CurrentStation

  ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    base_method_name = const_name.to_s.downcase
    eval <<-DEF
      def is_at_#{ base_method_name }?
        station_same_as__is_in?( ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.#{ base_method_name } )
      end
    DEF
  end

  ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    base_method_name = const_name.to_s.downcase
    eval <<-DEF
      def is_at_#{ base_method_name }?
        station_same_as__is_in?( ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.#{ base_method_name } )
      end
    DEF
  end

  ::TokyoMetro::CommonModules::Dictionary::Station::StringList.constants( false ).map { | const_name |
    const_name.to_s.downcase
  }.delete_if { | base_method_name |
    /_in_system\Z/ === base_method_name
  }.each do | base_method_name |
    case base_method_name
    # between で始まる場合
    when /\Abetween_/
      defined_method_name = "is_#{ base_method_name }?"
    # common_stations で終わる場合
    when /common_stations\Z/
      defined_method_name = "is_at_#{ base_method_name }?"
    # and が含まれる場合
    when /and/
      defined_method_name = "is_at_" + base_method_name.gsub( /and/ , "or" ) + "?"
    else
      next
    end

    eval <<-DEF
      def #{defined_method_name}
        station_same_as__is_in?( ::TokyoMetro::CommonModules::Dictionary::Station::StringList.#{base_method_name} )
      end
    DEF

  end

  def method_missing( method_name )
    valid_method = self.methods.find { | item | item == "is_#{ method_name.to_s }".intern }
    if valid_method.present?
      return send( valid_method )
    end
    super
  end

  private

  def station_same_as__is_in?( *variables , compared )
    raise if variables.empty?
    variables.flatten.any? { | item | item === compared }
  end

end