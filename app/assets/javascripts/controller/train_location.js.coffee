class TrainLocationInfos

  constructor: ( @domain = $( '#train_location_infos' ) ) ->

  has_train_location_infos = (v) ->
    return v.domain.length > 0

  has_train_type_infos = (v) ->
    return train_type_domains(v).length > 0

  ul_domains_of_train_locations_of_each_direction = (v) ->
    return v.domain
      .children( 'ul.train_locations_of_each_direction' )

  li_domains_of_train_locations = (v) ->
    return ul_domains_of_train_locations_of_each_direction(v)
      .children( 'li.train_location' )

  domains_of_train_fundamental_infos = (v) ->
    return li_domains_of_train_locations(v)
      .children( '.train_fundamental_infos' )

  train_type_domains = (v) ->
    return domains_of_train_fundamental_infos(v)
      .children( '.train_type' )

  process: ->
    if has_train_location_infos(@)
      process_each_train_location_info(@)
      if has_train_type_infos(@)
        set_width_of_train_type_domains(@)
      process_each_ul_domain(@)
      set_height_of_each_li_domain(@)
    return

  process_each_train_location_info = (v) ->
    li_domains_of_train_locations(v).each ->
      p = new TrainLocationInfo( $(@) )
      p.process()
      return
    return

  set_width_of_train_type_domains = (v) ->
    p = new DomainsCommonProcessor( train_type_domains(v) )
    w = Math.ceil( p.max_width() * 0.5 + 1 ) * 2
    p.set_css_attribute( 'width' , w )
    return

  process_each_ul_domain = (v) ->
    ul_domains_of_train_locations_of_each_direction(v).each ->
      ul_domain = $(@)
      p = new TrainLocationUlDomain( ul_domain )
      p.process()
      return
    return

  set_height_of_each_li_domain = (v) ->
    p = new DomainsCommonProcessor( li_domains_of_train_locations(v).children() )
    p.set_all_of_uniform_height_to_max()
    return

window.TrainLocationInfos = TrainLocationInfos

class TrainLocationInfo

  constructor: ( @domain ) ->

  train_fundamental_infos = (v) ->
    return v.domain
      .children( '.train_fundamental_infos' )
      .first()

  railway_line_matrix_very_small = (v) ->
    return train_fundamental_infos(v)
      .children( '.railway_line_matrix_very_small' )
      .first()

  terminal_station_info = (v) ->
    return train_fundamental_infos(v)
      .children( '.terminal_station' )
      .first()

  current_position = (v) ->
    return v.domain
      .children( '.current_position' )
      .first()

  ul_sub_infos = (v) ->
    return v.domain
      .children( 'ul.sub_infos' )
      .first()

  domain_of_station_infos_in_current_position = (v) ->
    return current_position(v)
      .children( '.station_infos' )
      .first()

  station_infos = (v) ->
    return v.domain
      .find( '.station_info' )

  time_info = (v) ->
    return ul_sub_infos(v)
      .children( '.time_info' )
      .first()

  starting_station = (v) ->
    return ul_sub_infos(v)
      .children( '.starting_station' )
      .first()

  train_number = (v) ->
    return ul_sub_infos(v)
      .children( '.train_number' )
      .first()

  has_station_code_text = (v) ->
    return station_codes(v).children( 'img' ).length is 0

  process: ->
    # console.log 'TrainLocationInfo\#process'
    set_height_and_vertical_align_of_railway_line_matrix(@)
    process_terminal_station_info(@)
    set_vertical_align_of_station_infos(@)
    set_vertical_align_of_time_info(@)
    set_width_of_title_in_ul_sub_infos(@)
    set_vertical_align_of_starting_station_and_train_number(@)
    return

  set_height_and_vertical_align_of_railway_line_matrix = (v) ->
    r_matrix =  railway_line_matrix_very_small(v)
    info = r_matrix.children( '.info' ).first()
    p1 = new DomainsVerticalAlignProcessor( info.children() )
    p1.process()

    p2 = new DomainsCommonProcessor( info.children() )
    info.css( 'height' , p2.max_outer_height( true ) )
    r_matrix.css( 'height' , info.outerHeight( true ) )
    return

  process_terminal_station_info = (v) ->
    station_info = new StationInfoProcessor( terminal_station_info(v) )
    station_info.process()
    return

  set_vertical_align_of_station_infos = (v) ->
    station_infos(v).each ->
      station_info = new StationInfoProcessor( $(@) )
      station_info.process()
      return
    return

  set_vertical_align_of_time_info = (v) ->
    time_info(v).children().not( '.icon' ).each ->
      content = $(@)
      p = new LengthToEven( content , true )
      p.set()
      return
    p = new DomainsVerticalAlignProcessor( time_info(v).children() )
    p.process()
    return

  set_width_of_title_in_ul_sub_infos = (v) ->
    titles = ul_sub_infos(v).find( '.starting_station_title , .title_of_train_number' )
    p = new DomainsCommonProcessor( titles )
    p.set_all_of_uniform_width_to_max()
    return

  set_vertical_align_of_starting_station_and_train_number = (v) ->
    $.each [ starting_station(v) , train_number(v) ] , ->
      content = $(@)
      p = new DomainsVerticalAlignProcessor( content.children() )
      p.process()
      return
    return

class TrainLocationUlDomain

  constructor: ( @ul_domain ) ->
    set_max_outer_width_of_domains_of_train_fundamental_infos(@)
    set_max_outer_width_of_ul_sub_infos(@)
    return

  li_train_locations = (v) ->
    return v.ul_domain
      .children( 'li.train_location' )

  domains_of_train_fundamental_infos = (v) ->
    return li_train_locations(v)
      .children( '.train_fundamental_infos' )

  railway_line_matrixes = (v) ->
    return domains_of_train_fundamental_infos(v)
      .children( '.railway_line_matrix_very_small' )

  current_positions = (v) ->
    return li_train_locations(v)
      .children( '.current_position' )

  ul_sub_infos = (v) ->
    return li_train_locations(v)
      .children( 'ul.sub_infos' )

  set_max_outer_width_of_domains_of_train_fundamental_infos = (v) ->
    p = new DomainsCommonProcessor( domains_of_train_fundamental_infos(v) )
    v.max_outer_width_of_domains_of_train_fundamental_infos = p.max_inner_width()
    return

  set_max_outer_width_of_ul_sub_infos = (v) ->
    p = new DomainsCommonProcessor( ul_sub_infos(v) )
    v.max_outer_width_of_ul_sub_infos = p.max_inner_width()
    return

  max_width_of_li_train_location = (v) ->
    p = new DomainsCommonProcessor( li_train_locations(v) )
    return p.max_inner_width()

  border_left_and_bottom_of_current_position = (v) ->
    p = new DomainsCommonProcessor( current_positions(v) )
    return p.max_outer_width( false ) - p.max_inner_width()

  width_of_current_position = (v) ->
    width_of_li = max_width_of_li_train_location(v)
    # console.log 'width_of_li: ' + width_of_li
    # console.log 'max_outer_width_of_domains_of_train_fundamental_infos: ' + v.max_outer_width_of_domains_of_train_fundamental_infos
    # console.log 'max_outer_width_of_ul_sub_infos: ' + v.max_outer_width_of_ul_sub_infos
    return width_of_li - ( v.max_outer_width_of_domains_of_train_fundamental_infos + v.max_outer_width_of_ul_sub_infos + border_left_and_bottom_of_current_position(v) )

  process: ->
    process_domains_of_train_fundamental_infos(@)
    process_ul_sub_infos(@)
    process_current_position(@)
    return

  process_domains_of_train_fundamental_infos = (v) ->
    w = v.max_outer_width_of_domains_of_train_fundamental_infos
    domains_of_train_fundamental_infos(v).css( 'width' , w )
    railway_line_matrixes(v).css( 'width' , w )
    return

  process_ul_sub_infos = (v) ->
    w = v.max_outer_width_of_ul_sub_infos
    ul_sub_infos(v).css( 'width' , w )
    return

  process_current_position = (v) ->
    w = width_of_current_position(v)
    current_positions(v).css( 'width' , w )
    return
