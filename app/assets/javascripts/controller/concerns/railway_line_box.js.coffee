class RailwayLineBoxBase
  constructor: ( @domain , @width ) ->
    # console.log 'RailwayLineBoxBase\#constructor -> '
    # console.log @domain
    # console.log 'children of domain: ' + @domain.children( '.info' ).first()
    # console.log 'children of domain: ' + info(@)

  info: ->
    return @domain.children( '.info' ).first()

  change_width: ->
    @domain.css( 'width' , @width )
    return

  inner_height = (v) ->
    return v.domain.innerHeight()

  railway_line_code = (v) ->
    return v.info().children( ).eq(0)

  railway_line_name_text_ja = (v) ->
    return v.info().children().eq(1)

  railway_line_name_text_en = (v) ->
    return v.info().children().eq(2)

  height_of_railway_line_infos = (v) ->
    return railway_line_code(v).outerHeight( true ) + railway_line_name_text_ja(v).outerHeight( true ) + railway_line_name_text_en(v).outerHeight( true )

  margin_top_and_bottom = (v) ->
    return ( inner_height(v) - height_of_railway_line_infos(v) ) * 0.5

  set_height_and_margin_of_info: ->
    # console.log @.info()
    _info = @.info()
    _margin_top_and_bottom = margin_top_and_bottom(@)
    _info.css( 'height' , height_of_railway_line_infos(@) )
    _info.css( 'margin-top' , _margin_top_and_bottom ).css( 'margin-bottom' , _margin_top_and_bottom )
    return

# 一般路線の box
class NormalRailwayLineBox extends RailwayLineBoxBase

  railway_line_code_outer = (v) ->
    return v.info().find( '.railway_line_code_outer' ).first()

  width_of_railway_line_code_outer = (v) ->
    return railway_line_code_outer(v).outerWidth( false )

  margin_of_railway_line_code_outer = (v) ->
    return ( v.info().innerWidth() - width_of_railway_line_code_outer(v) ) * 0.5

  # 路線記号の左右の margin の変更
  set_margin_of_railway_line_code_outer = (v) ->
    _railway_line_code_outer = railway_line_code_outer(v)
    _margin_of_railway_line_code_outer = margin_of_railway_line_code_outer(v)
    railway_line_code_outer(v).css( 'margin-left' , _margin_of_railway_line_code_outer ).css( 'margin-right' , _margin_of_railway_line_code_outer )
    return

  process: ->
    @.change_width()
    set_margin_of_railway_line_code_outer(@)
    @.set_height_and_margin_of_info()
    return

window.NormalRailwayLineBox = NormalRailwayLineBox


# 特殊な路線（「有楽町線・副都心線」を想定）
class SpecialRailwayLineBox extends RailwayLineBoxBase

  railway_line_codes = (v) ->
    return v.info().children( '.railway_line_codes' ).first()

  domains_of_railway_line_code_outer = (v) ->
    return railway_line_codes(v).find( '.railway_line_code_outer' )

  # 路線記号のサイズの取得
  width_and_height_of_railway_line_codes = (v) ->
    p = new DomainsCommonProcessor( domains_of_railway_line_code_outer(v) )
    return { width: p.max_outer_width( true ) , height: p.max_outer_height( true ) }

  # 路線記号の設定の変更
  process_railway_line_codes = (v) ->
    # console.log 'SpecialRailwayLineBox\#process_railway_line_codes'
    size_of_railway_line_code_box = width_and_height_of_railway_line_codes(v)
    _railway_line_codes = railway_line_codes(v)
    _railway_line_codes.css( 'height' , size_of_railway_line_code_box.height )
    _railway_line_codes.children().each ->
      railway_line_code_block = new SpecialRailwayLineBoxCodeBlock( $( this ) , size_of_railway_line_code_box )
      railway_line_code_block.process( _railway_line_codes )
      return
    return

  process: ->
    @.change_width()
    process_railway_line_codes(@)
    @.set_height_and_margin_of_info()
    return

window.SpecialRailwayLineBox = SpecialRailwayLineBox

class SpecialRailwayLineBoxCodeBlock
  constructor: ( @domain , @size ) ->

  width = (v) ->
    return v.size.width

  height = (v) ->
    return v.size.height

  railway_line_code_domains = (v) ->
    return v.domain.children()

  set_height = (v) ->
    v.domain.css( 'height' , height(v) )
    return

  # .yurakucho , .fukutoshin に幅と margin を設定
  set_size_and_margin_to_each_railway_line_domain = (v) ->
    margin = 4
    railway_line_code_domains(v).each ->
      # $( this ) - .yurakucho または .fukutoshin
      $( this ).css( 'width' , width(v) ).css( 'height' , height(v) ).css( 'margin-left' , margin ).css( 'margin-right' , margin )
      return
    return

  # .railway_line_code_block の幅
  width_of_railway_line_code_domain = (v) ->
    p = new DomainsCommonProcessor( railway_line_code_domains(v) )
    return p.sum_outer_width( true )

  margin_left_and_right_of_railway_line_code_block = (v,railway_line_codes) ->
    return ( railway_line_codes.innerWidth() - width_of_railway_line_code_domain(v) ) * 0.5

  set_margin_to_line_code_block = ( v , railway_line_codes ) ->
    _margin = margin_left_and_right_of_railway_line_code_block( v , railway_line_codes )
    v.domain.css( 'margin-left' , _margin ).css( 'margin-right' , _margin )
    return

  process: ( railway_line_codes ) ->
    set_height(@)
    set_size_and_margin_to_each_railway_line_domain(@)
    set_margin_to_line_code_block( @ , railway_line_codes )
    return