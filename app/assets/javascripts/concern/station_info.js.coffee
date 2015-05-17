class StationInfoProcessor

  constructor: ( @domain ) ->

  has_station_code = (v) ->
    return v.domain.children( '.station_codes , .station_code_outer' ).length is 1

  station_codes = (v) ->
    return v.domain.children( '.station_codes , .station_code_outer' ).first()

  station_code_image = (v) ->
    return station_codes(v).children( 'img.station_code' ).first()

  text_domain = (v) ->
    return v.domain.children( '.text' ).first()

  texts = (v) ->
    return text_domain(v).children()

  text_ja = (v) ->
    return text_domain(v).children( '.text_ja' )

  text_en = (v) ->
    return text_domain(v).children( '.text_en' )

  process: ( margin = 0 ) ->
    process_station_codes(@)
    process_text(@)
    # set_height_of_domain( @ , margin )
    set_vertical_align_of_domain(@)
    set_width_of_domain(@)
    return

  process_station_codes = (v) ->
    if has_station_code(v)
      station_codes(v).css( 'height' , station_code_image(v).outerHeight( true ) )
      return
    return

  process_text = (v) ->
    texts(v).each ->
      l = new LengthToEven( $(@) )
      l.set()
      return
    return

  set_vertical_align_of_domain = (v) ->
    if has_station_code(v)
      p1 = new DomainsCommonProcessor( v.domain.children() )
      _max_outer_height = p1.max_outer_height( true )
      p2 = new DomainsVerticalAlignProcessor( v.domain.children() , _max_outer_height , 'middle' )
      p2.process()
      return
    return

  set_width_of_domain = (v) ->
    if has_station_code(v)
      p = new DomainsCommonProcessor( v.domain.children() )
      v.domain.css( 'width' , p.sum_outer_width( true ) )
      return
    return

  max_outer_height_of_children: ( setting = false ) ->
    p = new DomainsCommonProcessor( @domain.children() )
    return p.max_outer_height( setting )

window.StationInfoProcessor = StationInfoProcessor