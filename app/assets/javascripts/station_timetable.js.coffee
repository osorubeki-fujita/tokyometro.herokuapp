processStationTimetable = ->
  timetables = $( 'table.timetable' )
  changeWidthOfOperationDay( timetables )
  changeAttibutesOfTopHeader( timetables )
  changeWidthOfTdHour( timetables )
  changeWidthOfMin( timetables )
  changeWidthAndHeightOfTrainTime( timetables )
  return

window.processStationTimetable = processStationTimetable

changeWidthOfOperationDay = ( timetables ) ->
  domains_of_weekday_and_holiday = timetables.find( '.operation_day' )
  changeWidthOfContentsInStationTimetable( domains_of_weekday_and_holiday )
  # setVarticalPositionOfOperationDay( domains_of_weekday_and_holiday )
  return

changeAttibutesOfTopHeader = ( timetables ) ->
  timetables.each ->
    timetable_top_header = $( this ).find( 'td.top_header' ).eq(0)
    main_domain = timetable_top_header.children( '.main' ).eq(0)
    max_height_of_main_domain = getMaxOuterHeight( main_domain.children() , true )
    
    main_domain.css( 'height' , max_height_of_main_domain )

    direction = main_domain.children( '.direction' ).eq(0)
    additional_infos = main_domain.children( '.additional_infos' ).eq(0)
    margin_top_and_bottom = ( max_height_of_main_domain - direction.height() ) * 0.5

    direction.css( 'margin-top' , margin_top_and_bottom )
    direction.css( 'margin-bottom' , margin_top_and_bottom )
    additional_infos.css( 'margin-top' , margin_top_and_bottom )
    return
  return

changeWidthOfTdHour = ( timetables ) ->
  domains_of_hour = timetables.find( '.hour' )
  changeWidthOfContentsInStationTimetable( domains_of_hour )
  return

changeWidthOfMin = ( timetables ) ->
  blocks = timetables.find( '.min' )
  width_new = getMaxWidth( blocks )
  setCssAttributesToEachDomain( blocks , 'width' , width_new )
  return

changeWidthAndHeightOfTrainTime = ( timetables ) ->
  timetables.each ->
    timetable = $( this )
    train_time_blocks = timetable.find( '.train_time' )
    train_time_block_max_width = getMaxWidth( train_time_blocks )

    setCssAttributesToEachDomain( train_time_blocks , 'width' , train_time_block_max_width )

    domains_of_each_hour = timetable.find( 'td.train_times' )
    domains_of_each_hour.each ->
      domain_of_an_hour = $( this )
      domains_of_train_times = domain_of_an_hour.children( '.train_time' )
      height_max = getMaxHeight( domains_of_train_times )

      setCssAttributesToEachDomain( domains_of_train_times , 'height' , height_max )
      return
    return
  return

changeWidthOfContentsInStationTimetable = ( blocks ) ->
  max_width = getMaxWidth( blocks )
  width_new = Math.ceil( max_width * goldenRatio )
  padding = Math.ceil( ( width_new - max_width ) * 0.5 )

  width_new = max_width + padding * 2
  setCssAttributesToEachDomain( blocks , 'width' , width_new )
  setCssAttributesToEachDomain( blocks , 'padding-left' , padding )
  setCssAttributesToEachDomain( blocks , 'padding-right' , padding )
  return

setVarticalPositionOfOperationDay = ( domains_of_weekday_and_holiday ) ->
  domains_of_weekday_and_holiday.each ->
    height_of_domain = $( this ).height()
    height_of_text = getMaxOuterHeight( $( this ).children() , true )
    padding_top_and_bottom = ( height_of_domain - height_of_text ) * 0.5

    $( this ).css( 'padding-top' , padding_top_and_bottom )
    $( this ).css( 'padding-bottom' , padding_top_and_bottom )
    return
  return