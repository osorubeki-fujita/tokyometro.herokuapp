class RailwayLineController < ApplicationController

  include EachRailwayLine
  include YurakuchoAndFukutoshinLine
  prepend MarunouchiLineBranch
  prepend ChiyodaLineBranch

  def index
    @title = "路線のご案内"
    render 'railway_line/index'
  end

  private

  def each_railway_line( *railway_line_name_codes )
    each_railway_line_sub( "路線のご案内" , "railway_line" , *railway_line_name_codes , with_branch: true , including_chiyoda_branch: true )
  end

end