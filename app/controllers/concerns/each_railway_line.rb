module EachRailwayLine

  extend ActiveSupport::Concern

  included do

    [ :ginza , :marunouchi , :hibiya , :tozai , :chiyoda , :yurakucho , :hanzomon , :namboku , :fukutoshin ].each do | railway_line_name |
      eval <<-DEF
        def #{railway_line_name}_line
          each_railway_line( "odpt.Railway:TokyoMetro.#{railway_line_name.capitalize}" )
        end
      DEF
    end

    private

    def each_railway_line_sub( title_base , controller , *railway_line_names , with_branch: false , including_chiyoda_branch: false , layout: "application" )
      if with_branch
        @railway_lines = ::RailwayLine.tokyo_metro( including_branch_line: true ).where( same_as: railway_line_names )
      else
        @railway_lines = ::RailwayLine.tokyo_metro.where( same_as: railway_line_names )
      end

      if @railway_lines.where( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ).present? and !( including_chiyoda_branch )
        @railway_lines = @railway_lines.where.not( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      end

      if block_given?
        yield
      end

      class << @railway_lines
        include ForRails::RailwayLineArrayModule
      end
      @title = @railway_lines.to_railway_line_name_text_ja + " #{title_base}"
      render "#{controller}/each_railway_line" , layout: layout
    end

  end

end