#-------- [class] StationFacilityPlatformInfoTabUl

class StationFacilityPlatformInfoTabUl extends TabUl

  constructor: ( @ul = $( 'ul#platform_info_tabs' ) ) ->

  has_ul = (v) ->
    return v.ul.length > 0

  # li_contents: ->
    # console.log 'StationFacilityPlatformInfoTabUl\#li_contents'
    # super()
    # return

  process: ->
    if has_ul(@)
      process_railway_line_name(@)
      super()
      return
    return

  process_railway_line_name = (v) ->
    # console.log( 'StationFacilityPlatformInfoTabUl\#process_railway_line_name' )
    # console.log(v)
    # console.log( v.li_contents() )
    v.li_contents().each ->
      tab_li = new StationFacilityPlatformInfoTabLi( $(@) )
      tab_li.process()
      return
    return

window.StationFacilityPlatformInfoTabUl = StationFacilityPlatformInfoTabUl

class StationFacilityPlatformInfoTabLi

  constructor: ( @domain ) ->

  railway_line_name_domain = (v) ->
    return v.domain.children( '.railway_line_name' ).first()

  children_of_railway_line_name_domain = (v) ->
    return railway_line_name_domain(v).children()

  text = (v) ->
    return railway_line_name_domain(v).children( '.text' ).first()

  process: ->
    process_text(@)
    _railway_line_name_domain = railway_line_name_domain(@)
    p = new DomainsCommonProcessor( children_of_railway_line_name_domain(@) )
    _railway_line_name_domain.css( 'width' , Math.ceil( p.sum_outer_width( true ) * 1.2 ) )
    # _railway_line_name_domain.css( 'height' , p.max_outer_height( true ) )
    return

  process_text = (v) ->
    p = new LengthToEven( text(v) , true )
    p.set()
    return
