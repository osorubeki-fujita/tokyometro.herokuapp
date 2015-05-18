class TrainLocationInfos

  constructor: ( @domains = $( '#train_location_infos' ) ) ->

  train_location_infos = (v) ->
    return v.domains.children( '.train_location' )

  process: ->
    train_location_infos(@).each ->
      t = new TrainLocationInfo( $( this ) )
      t.process()
      return
    return

window.TrainLocationInfos = TrainLocationInfos

class TrainLocationInfo

  constructor: ( @domain ) ->

  train_fundamental_infos = (v) ->
    return v.domain.children( '.train_fundamental_infos' ).first()

  train_infos = (v) ->
    return train_fundamental_infos(v).children( '.train_infos' ).first()

  sub_infos = (v) ->
    return v.domain.children( '.sub_infos' ).first()

  starting_station = (v) ->
    return sub_infos(v).children( '.starting_station' ).first()

  train_number = (v) ->
    return sub_infos(v).children( '.train_number' ).first()

  delay = (v) ->
    return sub_infos(v).children( '.delay' ).first()

  current_position = (v) ->
    return v.domain.children( '.current_position' ).first()

  process: ->
    process_train_fundamental_infos(@)
    process_sub_infos(@)
    process_current_position(@)
    set_domain_height(@)
    return

  process_train_fundamental_infos = (v) ->
    _train_infos = train_infos(v)
    terminal_station = _train_infos.children( '.terminal_station' )
    _terminal_station = new StationInfoProcessor( terminal_station )
    _terminal_station.process()

    _train_fundamental_infos = train_fundamental_infos(v)
    p = new DomainsCommonProcessor( _train_fundamental_infos.children() )
    p.set_all_of_uniform_width_to_max()
    _train_fundamental_infos.css( 'height' , p.max_outer_height( true ) )
    return

  process_sub_infos = (v) ->
    process_starting_station(v)
    process_train_number(v)
    process_delay(v)
    set_height_of_sub_infos(v)
    return

  process_starting_station = (v) ->
    _starting_station = starting_station(v)

    station_info = _starting_station.children( '.station_info' ).first()
    ps = new StationInfoProcessor( station_info )
    ps.process()

    p1 = new DomainsCommonProcessor( _starting_station.children() )
    _starting_station.css( 'height' , p1.max_outer_height( true ) )

    p2 = new DomainsVerticalAlignProcessor( _starting_station.children() , p1.max_outer_height( true ) , 'middle' )
    p2.process()
    return

  process_train_number = (v) ->
    _train_number = train_number(v)
    p = new DomainsCommonProcessor( _train_number.children() )
    p.set_all_of_uniform_width_to_max()
    _train_number.css( 'height' , p.max_outer_height( true ) )
    return

  process_delay = (v) ->
    _delay = delay(v)
    p = new DomainsCommonProcessor( _delay.children() )
    w = p.max_outer_width( true ) + 2
    _delay.children().each ->
      $( this ).css( 'width' , w )
      return
    _delay.css( 'height' , p.max_outer_height( true ) )
    return

  set_height_of_sub_infos = (v) ->
    _sub_infos = sub_infos(v)
    p = new DomainsCommonProcessor( _sub_infos.children() )
    _sub_infos.css( 'height' , p.max_outer_height( true ) )
    return

  process_current_position = (v) ->
    _current_position = new TrainLocationInfoCurrentPosition( current_position(v) )
    _current_position.process()
    return

  set_domain_height = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    v.domain.css( 'height' , p.sum_outer_height( true ) )
    return

class TrainLocationInfoCurrentPosition

  constructor: ( @domain ) ->

  title = (v) ->
    return v.domain.children( '.title_of_current_position' )

  domain_of_station_infos = (v) ->
    return v.domain.children( '.station_infos' ).first()

  station_infos = (v) ->
    return domain_of_station_infos(v).children( '.station_info' )

  arrow = (v) ->
    return domain_of_station_infos(v).children( '.arrow' )

  process_station_infos = (v) ->
    process_each_station_info(v)

    p = new DomainsCommonProcessor( station_infos(v) )
    p.set_all_of_uniform_height_to_max()
    max_outer_height = p.max_outer_height( true )

    process_arrow( v , max_outer_height )
    set_height_of_domain_of_station_infos( v , max_outer_height )
    return

  process_each_station_info = (v) ->
    station_infos(v).each ->
      p = new StationInfoProcessor( $( this ) )
      p.process()
      return
    return

  process_arrow = ( v , _max_outer_height ) ->
    switch arrow(v).length
      when 1
        p = new DomainsVerticalAlignProcessor( arrow(v) , _max_outer_height , 'middle' )
        p.process()
      when 0
        # console.log 'Nothing to do'
      else
        console.log 'Error'
    return

  set_height_of_domain_of_station_infos = ( v , max_outer_height ) ->
    domain_of_station_infos(v).css( 'height' , max_outer_height )
    return

  set_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    p.set_all_of_uniform_height_to_max()
    v.domain.css( 'height' , p.max_outer_height( true ) )
    return

  process: ->
    process_station_infos(@)
    set_height_of_children(@)
    return