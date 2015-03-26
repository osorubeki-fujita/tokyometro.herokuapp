class StationTimetables

  constructor: ( @domains = $( 'table.station_timetable' ) ) ->

  operation_day_domains = (v) ->
    return v.domains.find( '.operation_day' )

  hours = (v) ->
    return v.domains.find( '.hour' )

  mins = (v) ->
    return v.domains.find( '.min' )

  process_operation_day_domains = (v) ->
    _operation_day_domains = operation_day_domains(v)
    contents = new StationTimetableContentsOperation( _operation_day_domains )
    contents.decorate_contents()
    return

  process_top_headers = (v) ->
    v.domains.each ->
      d = new StationTimetableTopHeader( $( this ) )
      d.process()
      return
    return

  process_hours = (v) ->
    contents = new StationTimetableContentsHours( hours(v) )
    contents.decorate_contents()
    return  

  process_mins = (v) ->
    p = new DomainsCommonProcessor( mins(v) )
    p.set_css_attribute( 'width' , p.max_width() )
    return

  process_station_train_times = (v) ->
    v.domains.each ->
      t = new StationTimetable( $( this ) )
      t.process_station_train_times()
      return
    return

  process: ->
    console.log 'StationTimetables\#process (' + @domains.length + ')'
    if @domains.length > 0
      process_operation_day_domains(@)
      process_top_headers(@)
      process_hours(@)
      process_mins(@)
      process_station_train_times(@)
      return

window.StationTimetables = StationTimetables

class StationTimetableBase
  constructor: ( @domain ) ->

class StationTimetableTopHeader extends StationTimetableBase

  top_header = (v) ->
    return v.domain.find( 'td.top_header' ).first()

  main_domain = (v) ->
    return top_header(v).children( '.main' ).first()

  max_height_of_main_domain = (v) ->
    p = new DomainsCommonProcessor( main_domain(v).children() )
    return p.max_outer_height( true )

  direction = (v) ->
    return main_domain(v).children( '.direction' ).first()

  additional_infos = (v) ->
    return main_domain(v).children( '.additional_infos' ).first()

  margin_top_and_bottom_of_direction_and_additional_infos = (v) ->
    return ( max_height_of_main_domain(v) - direction(v).height() ) * 0.5

  process: ->
    main_domain(@).css( 'height' , max_height_of_main_domain(@) )

    _direction = direction(@)
    _margin_top_and_bottom_of_direction_and_additional_infos = margin_top_and_bottom_of_direction_and_additional_infos(@)
    _additional_infos = additional_infos(@)

    _direction.css( 'margin-top' , _margin_top_and_bottom_of_direction_and_additional_infos )
    _direction.css( 'margin-bottom' , _margin_top_and_bottom_of_direction_and_additional_infos )
    _additional_infos.css( 'margin-top' , _margin_top_and_bottom_of_direction_and_additional_infos )
    return

class StationTimetable extends StationTimetableBase

  station_train_times = (v) ->
    return v.domain.find( '.station_train_time' )

  rows_of_each_hour = (v) ->
    return v.domain.find( 'td.station_train_times' )

  set_max_width_to_all_station_train_times = (v) ->
    p = new DomainsCommonProcessor( station_train_times(v) )
    p.set_css_attribute( 'width' , p.max_width() )
    return

  set_height_of_contents_in_each_hour = (v) ->
    rows_of_each_hour(v).each ->
      d = new StationTimetableTrainTimesOfEachHour( $( this ) )
      d.set_max_height_to_all()
      return
    return

  process_station_train_times: ->
    set_max_width_to_all_station_train_times(@)
    set_height_of_contents_in_each_hour(@)
    return

class StationTimetableTrainTimesOfEachHour
  constructor: ( @domain ) ->

  station_train_times = (v) ->
    return v.domain.children( '.station_train_time' )

  set_max_height_to_all: ->
    p = new DomainsCommonProcessor( station_train_times(@) )
    p.set_css_attribute( 'height' , p.max_height() )
    return

class StationTimetableContents
  constructor: ( @domains ) ->
    p = new DomainsCommonProcessor( @domains )
    @max_width = p.max_width()
    @inner_width_new = Math.ceil( @max_width * goldenRatio )
    @padding_new = Math.ceil( ( @inner_width_new - @max_width ) * 0.5 )
    return

  width_new = (v) ->
    return v.max_width + v.padding_new * 2

  decorate_contents: ->
    p = new DomainsCommonProcessor( @domains )
    p.set_css_attribute( 'width' , width_new(@) )
    p.set_css_attribute( 'padding-left' , @padding_new )
    p.set_css_attribute( 'padding-right' , @padding_new )
    return

class StationTimetableContentsOperation extends StationTimetableContents
  set_vertical_position = (v) ->
    v.domains.each ->
      operation_day = new StationTimetableContentsOperationDay( $( this ) )
      operation_day.set_vertical_positon()
      return
    return

  decorate_contents: ->
    # set_vertical_position(@)
    super()
    return

class StationTimetableContentsOperationDay
  constructor: ( @domain ) ->

  height = (v) ->
    return v.domain.height()

  height_of_text = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( true )

  padding_top_and_bottom = (v) ->
    return ( height(v) - height_of_text(v) ) * 0.5

  set_vertical_positon: ->
    _padding_top_and_bottom = padding_top_and_bottom(@)
    operation_day.css( 'padding-top' , padding_top_and_bottom )
    operation_day.css( 'padding-bottom' , padding_top_and_bottom )
    return

class StationTimetableContentsHours extends StationTimetableContents