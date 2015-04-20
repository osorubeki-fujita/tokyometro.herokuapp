class LinksToStationInfoPages

  constructor: ( @domain = $( '#station_link_list' ) ) ->

  has_station_link_list = (v) ->
    return ( v.domain.children().length > 0 )

  station_link_list_ja = (v) ->
    return v.domain.children( 'ul#station_link_list_ja' )

  station_link_list_en = (v) ->
    return v.domain.children( 'ul#station_link_list_en' )

  columns = (v) ->
    d = v.domain.find( 'ul.hiragana_column, ul.alphabet_column' )
    # console.log d
    return d

  process_each_column = (v) ->
    _columns = columns(v)
    # console.log _columns
    p = new DomainsCommonProcessor( _columns )
    p.set_css_attribute( 'width' , p.max_inner_width() )
    return

  set_height_of_lists = (v) ->
    v.domain.children( 'ul' ).each ->
      list = $( this )
      cols = list.children( 'ul' )
      p = new DomainsCommonProcessor( cols )
      list.css( 'height' , p.max_inner_height() )
      return
    return

  process: ->
    if has_station_link_list(@)
      # console.log 'LinksToStationInfoPages\#process: has_station_link_list ---> true'
      process_each_column(@)
      set_height_of_lists(@)
    else
      # console.log 'LinksToStationInfoPages\#process: has_station_link_list ---> false'
    return

window.LinksToStationInfoPages = LinksToStationInfoPages