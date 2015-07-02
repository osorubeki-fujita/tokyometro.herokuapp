class StationLinkList

  constructor: ( @domain = $( '#station_link_list' ) ) ->

  has_station_link_list = (v) ->
    return ( v.domain.children().length > 0 )

  station_link_list_ja = (v) ->
    return v.domain.children( 'ul#station_link_list_ja' )

  station_link_list_en = (v) ->
    return v.domain.children( 'ul#station_link_list_en' )

  columns = (v) ->
    return v.domain.find( 'ul.hiragana_column, ul.alphabet_column' )

  li_stations = (v) ->
    return columns(v).find( 'ul.stations' ).children( 'li.station' )

  process: ->
    if has_station_link_list(@)
      # console.log 'StationLinkList\#process: has_station_link_list ---> true'
      process_each_column(@)
      set_height_of_lists(@)
      set_tooltips(@)
    # else
      # console.log 'StationLinkList\#process: has_station_link_list ---> false'
    return

  process_each_column = (v) ->
    _columns = columns(v)
    # console.log _columns
    p = new DomainsCommonProcessor( _columns )
    p.set_css_attribute( 'width' , p.max_inner_width() )
    return

  set_height_of_lists = (v) ->
    v.domain.children( 'ul' ).each ->
      list = $(@)
      cols = list.children( 'ul' )
      p = new DomainsCommonProcessor( cols )
      list.css( 'height' , p.max_inner_height() )
      return
    return
  
  set_tooltips = (v) ->
    p = new TooltipsOnLinksToStation( li_stations(v).children( 'a' ) )
    p.set()
    return

window.StationLinkList = StationLinkList
