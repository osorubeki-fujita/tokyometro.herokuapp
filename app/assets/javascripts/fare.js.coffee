class FareTables
  constructor: ( @domains = $( '#fare_tables' ) ) ->

  tables = (v) ->
    return v.domains.children( '.fare_table' )

  process: ->
    tables(@).each ->
      t = new FareTable( $( this ) )
      t.process()
    return

window.FareTables = FareTables

class FareTable

  constructor: ( @domain ) ->

  tbody = (v) ->
    return v.domain.children( 'tbody' ).first()

  tr_rows = (v) ->
    return tbody(v).children( 'tr' )

  process: ->
    tr_rows(@).each ->
      r = new FareTableRow( $( this ) )
      r.process()
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