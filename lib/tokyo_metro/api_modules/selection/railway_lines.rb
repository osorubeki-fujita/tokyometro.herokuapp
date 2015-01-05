module TokyoMetro::ApiModules::Selection::RailwayLines

  [
    :ginza , :marunouchi , :marunouchi_branch , :hibiya , :tozai ,
    :chiyoda , :yurakucho , :hanzomon , :namboku , :fukutoshin
  ].each do | railway_line |
    eval <<-DEF
      def #{ railway_line.to_s }
        select_railway_line( :#{ railway_line.to_s } )
      end
      alias :#{ railway_line.to_s }_line :#{ railway_line.to_s }
    DEF
  end

  def marunouchi_including_branch
    select_railway_line( :marunouchi , :marunouchi_branch )
  end

  def yurakucho_or_fukutoshin
    select_railway_line( :yurakucho , :fukutoshin )
  end

  alias :marunouchi_line_including_branch :marunouchi_including_branch
  alias :yurakucho_or_fukutoshin_line :yurakucho_or_fukutoshin

  private

  def select_railway_line( *symbol_of_railway_lines )
    list_of_railway_lines_same_as = symbol_of_railway_lines.map { | method_name |
      ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringInfo.send( method_name )
    }

    self.class.new( self.select { | item |
      list_of_railway_lines_same_as.include?( item.railway_line )
    } )
  end

end