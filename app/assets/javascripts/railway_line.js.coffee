processRailwayLine = ->
    processWomenOnlyCar()

window.processRailwayLine = processRailwayLine

processWomenOnlyCar = ->
  women_only_car_info_domain = $( '#women_only_car' )
  section_domains = women_only_car_info_domain.find( '.section' )
  section_domains.children( '.section_infos' ).each ->
    section_infos = $( this )
    processWomenOnlyCarSectionInfos( section_infos )
    return
  processWomenOnlyCarPlaceDomains( women_only_car_info_domain.find( '.place' ) )
  return

processWomenOnlyCarPlaceDomains = ( place_domains ) ->
  place_domains_max_width = getMaxWidth( place_domains ) * 1.2
  place_domains.each ->
    place = $( this )
    place.css( 'width' , place_domains_max_width )
    return
  return
    
processWomenOnlyCarSectionInfos = ( section_infos ) ->
  available_time = section_infos.children().eq(0)
  infos = section_infos.children().eq(1)
  infos.children( '.info' ).each ->
    processWomenOnlyCarInfo( $( this ) )
    return
  infos.css( 'height' , getSumOuterHeight( infos.children( '.info' ) , true ) )
  section_infos.css( 'height' , getMaxOuterHeight( section_infos.children() , true ) )
  if available_time.outerHeight( false ) < infos.outerHeight( false )
    higher = infos
    shorter = available_time
  else
    higher = available_time
    shorter = infos
  margin_of_shorter = ( higher.outerHeight( false ) - shorter.outerHeight( false ) ) * 0.5
  shorter.css( 'margin-top' , margin_of_shorter ).css( 'margin-bottom' , margin_of_shorter )
  return

processWomenOnlyCarInfo = ( info ) ->
  car_domains = info.find( '.car' )
  max_outer_height_of_car_domains = getMaxOuterHeight( car_domains , false ) * 1.5
  info.find( '.car' ).each ->
    car = $( this )
    current_height = car.outerHeight( false )
    padding_top_and_bottom = ( max_outer_height_of_car_domains - current_height ) * 0.5
    car.css( 'padding-top' , padding_top_and_bottom ).css( 'padding-bottom' , padding_top_and_bottom )
    return
  setAllOfUniformHeightToMax( info.children() )
  info.css( 'height' , getMaxOuterHeight( info.children() , true ) )
  return