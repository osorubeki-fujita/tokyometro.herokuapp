module TokyoMetro::CommonModules::Decision::RailwayLine

  # @!group 路線に関するメソッド

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/railway_line/tokyo_metro_lines_in_system.yaml" ).each do | item |
    railway_line_base_name = item.underscore.downcase
    eval <<-DEF
      def is_on_#{ railway_line_base_name }_line?
        is_on_the_railway_line_of?( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringInfo.#{railway_line_base_name} )
      end
    DEF
  end

  def is_on_marunouchi_line_including_branch?
    is_on_the_railway_line_of?( *( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_same_as ) )
  end

  def is_on_yurakucho_or_fukutoshin_line?
    is_on_the_railway_line_of?( *( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as ) )
  end

  def method_missing( method_name )
    if /\A(?:is_)?(?:on_)?(\w+\?)\Z/ =~ method_name.to_s
      valid_method = "is_on_#{$1}".intern
      if methods.include?( valid_method )
        return send( valid_method )
      end
    end
    super
  end

  private

  def is_on_the_railway_line_of?( *variables , compared )
    raise if variables.empty?
    variables.flatten.include?( compared )
  end

end