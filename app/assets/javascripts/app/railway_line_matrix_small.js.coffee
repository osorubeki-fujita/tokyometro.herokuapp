class RailwayLineMatrixSmallInfo

  constructor: ( @domain ) ->

  railway_line_code_outer = (v) ->
    return v.domain.children( '.railway_line_code_outer' ).first()

  text = (v) ->
    return v.domain.children( '.text' ).first()

  max_height_of_railway_line_code_outer_and_text: ->
    return Math.max( Math.ceil( railway_line_code_outer(@).outerHeight( true ) ) , Math.ceil( text(@).outerHeight( true ) ) )

  sum_outer_width_of_railway_line_code_outer_and_text: ->
    return Math.ceil( railway_line_code_outer(@).outerWidth( true ) ) + Math.ceil( text(@).outerWidth( true ) )

  # info 領域の高さを設定し、railway_line_code_outer と text の上下方向の位置を中心揃えにする
  set_height_and_vertical_align_center: ->
    _max_height = @.max_height_of_railway_line_code_outer_and_text()
    $( [ railway_line_code_outer(@) , text(@) ] ).each ->
      margin = ( _max_height - $( this ).outerHeight( true ) ) * 0.5
      $( this ).css( 'margin-top' , margin )
      $( this ).css( 'margin-bottom' , margin )
      return
    @.set_max_height()
    return

  set_max_height: ->
    @domain.css( 'height' , @.max_height_of_railway_line_code_outer_and_text() )
    return

  set_margin_top_and_bottom: ( railway_line_matrix_small_inner_height ) ->
    # console.log( 'RailwayLineMatrixSmallInfo\#set_margin' )
    margin_top_and_bottom = ( railway_line_matrix_small_inner_height - @domain.outerHeight() ) * 0.5
    @domain.css( 'margin-top' , margin_top_and_bottom ).css( 'margin-bottom' , margin_top_and_bottom )
    return

  initialize_text_size: ->
    p = new DomainsCommonProcessor( text(@).children() )
    text(@).css( 'width' , Math.ceil( p.max_outer_width( true ) ) + 1 )

window.RailwayLineMatrixSmallInfo = RailwayLineMatrixSmallInfo