class RailwayLineCodes
  constructor: ( @domains = $( 'div.railway_line_code_48 , div.railway_line_code_32 , div.railway_line_code_24 , div.railway_line_code_16' ) ) ->

  move_letters_to_center = (v) ->
    v.domains.each ->
      c = new RailwayLineCode( $( this ) )
      c.move_letter_to_center()
      return
    return

  process: ->
    move_letters_to_center(@)
    return

window.RailwayLineCodes = RailwayLineCodes

class RailwayLineCode
  constructor: ( @domain ) ->

  p_domains = (v) ->
    return v.domain.children( 'p' )

  height = (v) ->
    return v.domain.innerHeight()

  move_letter_to_center: ->
    _height = height(@)
    p_domains(@).each ->
      d = new RailwayLineCodeLetter( $( this ) , _height )
      d.move_to_center()
      return
    return

class RailwayLineCodeLetter
  constructor: ( @domain , @height_of_railway_line_code ) ->

  # p タグの高さ (outerHeight)
  outer_height = (v) ->
    return v.domain.outerHeight( true )

  # p タグの上下の margin
  margin_top_and_bottom = (v) ->
    return ( v.height_of_railway_line_code - outer_height(v) ) * 0.5

  # 路線記号の文字の垂直方向の位置を、円の中心へ
  move_to_center: ->
    _margin_top_and_bottom = margin_top_and_bottom(@)
    @domain.css( 'margin-top' , _margin_top_and_bottom ).css( 'margin-bottom' , _margin_top_and_bottom )
    return