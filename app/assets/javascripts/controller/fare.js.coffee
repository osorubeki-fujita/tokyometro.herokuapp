class FareTables

  constructor: ( @domains = $( '#fare_tables' ) ) ->

  tables = (v) ->
    return v.domains.children( '.fare_table' )

  content_headers = (v) ->
    return $( '#links_to_station_info_pages , #fare_contents' )
      .children( '.content_header' )

  has_table = (v) ->
    return tables(v).length > 0

  process: ->
    if has_table(@)
      process_content_headers(@)
      process_each_fare_table(@)
      process_links_to_railway_line_pages(@)
    return

  process_content_headers = (v) ->
    p = new ContentHeaderProcessor( content_headers(v) )
    p.process()
    return

  process_each_fare_table = (v) ->
    tables(v).each ->
      t = new FareTable( $( this ) )
      t.process()
      return
    return

  process_links_to_railway_line_pages = (v) ->
    # console.log 'FareTables\#process_links_to_railway_line_pages'
    l = new LinksToRailwayLinePages( $( 'ul#links_to_railway_line_pages' ) , 'fare' )
    l.process()
    return

window.FareTables = FareTables

class FareTable

  constructor: ( @domain ) ->

  thead = (v) ->
    return v.domain.children( 'thead' ).first()

  tbody = (v) ->
    return v.domain.children( 'tbody' ).first()

  tr_header_rows = (v) ->
    return thead(v).children( 'tr' )

  tr_rows = (v) ->
    return tbody(v).children( 'tr' )

  process: ->
    tr_header_rows(@).each ->
      r = new FareTableHeaderRow( $(@) )
      r.process()
      return
    tr_rows(@).each ->
      r = new FareTableRow( $(@) )
      r.process()
      return
    return

class FareTableHeaderRow

  constructor: ( @domain ) ->

  station_name_top = (v) ->
    return v.domain.children( 'td.station_name_top')

  has_station_name_top = (v) ->
    return station_name_top(v).length > 0

  starting_station_info = (v) ->
    return station_name_top(v).children( '.starting_station_info' ).first()

  process: ->
    if has_station_name_top(@)
      s = new StationInfoProcessor( starting_station_info(@) )
      s.process()
    return

class FareTableRow

  constructor: ( @domain ) ->

  station_info = (v) ->
    return v.domain.children( '.station_info' ).first()

  station_info_domain = (v) ->
    return station_info(v).children( '.station_info_domain' ).first()

  station_code_outer = (v) ->
    return station_info_domain(v).children( '.station_code_outer' ).first()

  process: ->
    s = new StationInfoProcessor( station_info_domain(@) )
    station_info_domain(@).css( 'height' , s.max_outer_height_of_children( true ) )
    s.process()
    return
