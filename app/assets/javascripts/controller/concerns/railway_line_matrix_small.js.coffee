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

  # text 領域の高さを設定し、railway_line_code_outer と text の上下方向の位置を中心揃えにする
  set_vertical_align_center: ->
    @.initialize_text_size()
    p = new DomainsVerticalAlignProcessor( @domain.children() , @.max_height_of_railway_line_code_outer_and_text() )
    p.process()
    return

  set_margin_top_and_bottom: ( railway_line_matrix_small_inner_height ) ->
    p = new DomainsVerticalAlignProcessor( @domain , railway_line_matrix_small_inner_height )
    p.process()
    return

  initialize_text_size: ->
    p = new LengthToEven( text(@) )
    p.set()
    return

window.RailwayLineMatrixSmallInfo = RailwayLineMatrixSmallInfo