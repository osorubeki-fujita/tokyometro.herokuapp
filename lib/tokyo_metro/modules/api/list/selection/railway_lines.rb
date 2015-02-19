module TokyoMetro::Modules::Api::List::Selection::RailwayLines

  # @!group 路線名に関するメソッド

  [
    :ginza , :marunouchi , :marunouchi_branch , :hibiya , :tozai ,
    :chiyoda , :chiyoda_branch , :yurakucho , :hanzomon , :namboku , :fukutoshin ,
    :toei_mita
  ].each do | railway_line |
    eval <<-DEF
      def #{ railway_line }
        select_railway_line( :#{ railway_line } )
      end

      #-------- [alias]
      alias :#{ railway_line }_line :#{ railway_line }
    DEF
  end

  def marunouchi_including_branch
    select_railway_line( :marunouchi , :marunouchi_branch )
  end

  def chiyoda_including_branch
    select_railway_line( :chiyoda , :chiyoda_branch )
  end

  def yurakucho_or_fukutoshin
    select_railway_line( :yurakucho , :fukutoshin )
  end

  def namboku_or_toei_mita
    select_railway_line( :namboku , :toei_mita )
  end

  #-------- [alias]
  alias :marunouchi_line_including_branch :marunouchi_including_branch

  alias :yurakucho_or_fukutoshin_line :yurakucho_or_fukutoshin
  alias :yurakucho_and_fukutoshin :yurakucho_or_fukutoshin
  alias :yurakucho_and_fukutoshin_line :yurakucho_or_fukutoshin

  alias :namboku_or_toei_mita_line :namboku_or_toei_mita
  alias :namboku_and_toei_mita :namboku_or_toei_mita
  alias :namboku_and_toei_mita_line :namboku_or_toei_mita

  # @!endgroup

  private

  def select_railway_line( *symbol_of_railway_lines )
    list_of_railway_lines_same_as = select_railway_line__list_of_railway_lines_same_as( symbol_of_railway_lines )

    self.class.new( self.select { | item |
      item.send( :on_the_railway_line_of? , *list_of_railway_lines_same_as )
    } )
  end

  def select_railway_line__list_of_railway_lines_same_as( symbol_of_railway_lines )
    symbol_of_railway_lines.map { | method_name |
      ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.railway_line_string_list_in_system( method_name )
    }.flatten
  end

end