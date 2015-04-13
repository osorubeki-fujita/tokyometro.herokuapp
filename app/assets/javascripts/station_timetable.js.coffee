#-------- StationTimetables

# 複数の時刻表 table.station_timetable を扱うクラス
class StationTimetables

  constructor: ( @domains = $( 'table.station_timetable' ) ) ->

  top_headers = (v) ->
    return v.domains.find( 'td.top_header' )

  hours = (v) ->
    return v.domains.find( '.hour' )

  mins = (v) ->
    return v.domains.find( '.min' )

  process_top_headers = (v) ->
    _top_headres = new StationTimetableTopHeaders( top_headers(v) )
    _top_headres.process()
    return

  process_hours = (v) ->
    _hours = new StationTimetableHours( hours(v) )
    _hours.process()
    return  

  process_mins = (v) ->
    p = new DomainsCommonProcessor( mins(v) )
    p.set_css_attribute( 'width' , p.max_width() )
    return

  process_station_train_times = (v) ->
    v.domains.each ->
      _station_timetable = new StationTimetable( $( this ) )
      _station_timetable.process_station_train_times()
      return
    return

  process: ->
    # console.log 'StationTimetables\#process (' + @domains.length + ')'
    if @domains.length > 0
      process_top_headers(@)
      process_hours(@)
      process_mins(@)
      process_station_train_times(@)
      return
    return

window.StationTimetables = StationTimetables

#-------- StationTimetableDomainsBase , StationTimetableDomainBase

# 時刻表に関する複数の領域を扱うクラス
class StationTimetableDomainsBase
  constructor: ( @domains ) ->

# 時刻表に関する個別の領域を扱うクラス
class StationTimetableDomainBase
  constructor: ( @domain ) ->

#-------- StationTimetableTopHeaders , StationTimetableTopHeader

class StationTimetableTopHeaders extends StationTimetableDomainsBase

  operation_day_domains = (v) ->
    return v.domains.find( '.operation_day' )

  process_operation_day_domains = (v) ->
    _operation_day_domains = operation_day_domains(v)
    # console.log 'StationTimetableTopHeaders\#process_operation_day_domains' + ' / size: ' + _operation_day_domains.length

    __operation_day_domains = new StationTimetableContentsOperationDayDomains( _operation_day_domains )
    __operation_day_domains.process()
    return

  process: ->
    process_operation_day_domains(@)
    @domains.each ->
      d = new StationTimetableTopHeader( $( this ) )
      d.process()
      return
    return

class StationTimetableTopHeader extends StationTimetableDomainBase

  main_domain = (v) ->
    return v.domain.children( '.main' ).first()

  max_height_of_main_domain = (v) ->
    p = new DomainsCommonProcessor( main_domain(v).children() )
    return p.max_outer_height( true )

  direction = (v) ->
    return main_domain(v).children( '.direction' ).first()

  additional_infos = (v) ->
    return main_domain(v).children( '.additional_infos' ).first()

  margin_top_and_bottom_of_direction_and_additional_infos = (v) ->
    return ( max_height_of_main_domain(v) - direction(v).height() ) * 0.5

  set_height_to_main_domain = (v) ->
    main_domain(v).css( 'height' , max_height_of_main_domain(v) )
    return

  set_margin_to_direction = ( v , margin ) ->
    _direction = direction(v)
    _direction.css( 'margin-top' , margin )
    _direction.css( 'margin-bottom' , margin )
    return

  set_margin_to_additional_infos = ( v , margin ) ->
    _additional_infos = additional_infos(v)
    _additional_infos.css( 'margin-top' , margin )
    return

  process: ->
    _margin_top_and_bottom_of_direction_and_additional_infos = margin_top_and_bottom_of_direction_and_additional_infos(@)

    set_height_to_main_domain(@)
    set_margin_to_direction( @ , _margin_top_and_bottom_of_direction_and_additional_infos )
    set_margin_to_additional_infos( @ , _margin_top_and_bottom_of_direction_and_additional_infos )
    return

#-------- StationTimetableContentsOperationDayDomains , StationTimetableContentsOperationDayDomain

class StationTimetableContentsOperationDayDomains extends StationTimetableDomainsBase
  set_vertical_positions = (v) ->
    # console.log 'StationTimetableContentsOperationDayDomains\#set_vertical_positions / size: ' + v.domains.length
    # console.log v.domains.attr( 'class' )

    v.domains.each ->
      # console.log 'StationTimetableContentsOperationDayDomains\#set_vertical_positions - each'
      # console.log $( this )
      # console.log $( this ).attr( 'class' )

      operation_day = new StationTimetableContentsOperationDayDomain( $( this ) )
      operation_day.set_vertical_positon()
      return
    return

  set_widthes = (v) ->
    p = new DomainsCommonProcessor( v.domains )
    max_width = p.max_width()
    v.domains.each ->
      operation_day = new StationTimetableContentsOperationDayDomain( $( this ) )
      operation_day.set_width( max_width )
      return
    return

  process: ->
    set_vertical_positions(@)
    set_widthes(@)
    return

class StationTimetableContentsOperationDayDomain extends StationTimetableDomainBase

  height = (v) ->
    # console.log 'StationTimetableContentsOperationDayDomain\#height'
    # console.log v.domain
    return v.domain.height()

  height_of_text = (v) ->
    # console.log 'StationTimetableContentsOperationDayDomain\#height_of_text'
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( true )

  padding_top_and_bottom = (v) ->
    # console.log 'StationTimetableContentsOperationDayDomain\#padding_top_and_bottom'
    return ( height(v) - height_of_text(v) ) * 0.5

  set_vertical_positon: ->
    # console.log 'StationTimetableContentsOperationDayDomain\#set_vertical_positon'
    # console.log @domain
    _padding_top_and_bottom = padding_top_and_bottom(@)
    @domain.css( 'padding-top' , _padding_top_and_bottom )
    @domain.css( 'padding-bottom' , _padding_top_and_bottom )
    return

  set_width: ( width ) ->
    @domain.css( 'width' , width )
    return

#-------- StationTimetableContents , StationTimetableHours

class StationTimetableContents
  constructor: ( @domains ) ->
    p = new DomainsCommonProcessor( @domains )
    max_width = p.max_width()
    inner_width_new = Math.ceil( @max_width * goldenRatio )
    @padding_left_and_right_new = Math.ceil( ( inner_width_new - max_width ) * 0.5 )
    @width_new = inner_width_new + @padding_left_and_right_new * 2
    return

  process: ->
    p = new DomainsCommonProcessor( @domains )

    p.set_css_attribute( 'width' , @width_new )
    p.set_css_attribute( 'padding-left' , @padding_left_and_right_new )
    p.set_css_attribute( 'padding-right' , @padding_left_and_right_new )
    return

class StationTimetableHours extends StationTimetableContents

#-------- StationTimetable

class StationTimetable extends StationTimetableDomainBase

  station_train_times = (v) ->
    return v.domain.find( '.station_train_time' )

  td_rows_of_each_hour = (v) ->
    return v.domain.find( 'td.station_train_times' )

  set_max_width_to_all_station_train_times = (v) ->
    _station_train_times = new StationTimetableStationTrainTimes( station_train_times(v) )
    _station_train_times.set_max_width_to_all()

  set_max_height_to_station_train_times_in_each_hour = (v) ->
    td_rows_of_each_hour(v).each ->
      _station_train_times = new StationTimetableTrainTimesInEachHour( $( this ) )
      _station_train_times.set_max_height_to_all()
      return
    return

  process_station_train_times: ->
    set_max_width_to_all_station_train_times(@)
    set_max_height_to_station_train_times_in_each_hour(@)
    return

#-------- StationTimetableStationTrainTimes

class StationTimetableStationTrainTimes extends StationTimetableDomainsBase

  set_max_width_to_all: ->
    p = new DomainsCommonProcessor( @domains )
    p.set_css_attribute( 'width' , Math.ceil( p.max_width() ) + 1 )
    return

class StationTimetableTrainTimesInEachHour extends StationTimetableDomainBase

  station_train_times = (v) ->
    return v.domain.find( '.station_train_time' )

  set_max_height_to_all: ->
    p = new DomainsCommonProcessor( station_train_times(@) )
    p.set_css_attribute( 'height' , p.max_height() )
    return