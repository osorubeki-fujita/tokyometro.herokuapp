processStationFacility = ->
  processRailwayLinesRelatedToThisStation()
  processStationFacilityPlatformInfoTabs()
  processStationFacilityPlatformInfos()
  return

window.processStationFacility = processStationFacility

processRailwayLinesRelatedToThisStation = ->
  tokyo_metro_railway_lines = $( '.tokyo_metro_railway_lines' ).first().children( '.railway_lines' ).first()
  railway_lines_in_this_station = tokyo_metro_railway_lines.children( '.railway_lines_in_this_station' ).first()
  railway_lines_in_another_station = tokyo_metro_railway_lines.children( '.railway_lines_in_another_station' ).first()
  other_railway_lines = $( '.other_railway_lines' ).first().children( '.railway_lines' ).first()
  #
  $.each [ railway_lines_in_this_station , railway_lines_in_another_station , other_railway_lines ] , ->
    domains = $( this ).children()
    $( this ).css(  'height' , getMaxOuterHeight( domains , true ) )
    return
  #
  tokyo_metro_railway_lines.css( 'height' , getSumOuterHeight( tokyo_metro_railway_lines.children() , true ) )
  return

processStationFacilityPlatformInfoTabs = ->
  $( '#platform_info_tabs' ).children( 'ul' ).first().children( 'li' ).each ->
    platform_info_tab = $( this )
    railway_line_name = platform_info_tab.children( '.railway_line_name' ).first()
    children_of_railway_line_name = railway_line_name.children()
    railway_line_name.css( 'width' , getSumOuterWidth( children_of_railway_line_name , true ) )
    railway_line_name.css( 'height' , getMaxOuterHeight( children_of_railway_line_name , true ) )
    return
  return

processStationFacilityPlatformInfos = ->
  platform_info_tab_contents = $( '#platform_info_tab_contents' )
  tables = platform_info_tab_contents.find( 'table.platform_info' )
  tables.each ->
    table = $( this )
    table.find( '.transfer_info' ).each ->
      transfer_info = $( this )
      #
      railway_line_code = transfer_info.children().eq(0)
      railway_line_code_main = railway_line_code.children().first()
      railway_line_code.css( 'height' , railway_line_code_main.outerHeight( true ) ).css( 'width' , railway_line_code_main.outerWidth( true ) ).css( 'float' , 'left' )
      #
      string_domain = transfer_info.children( '.string' ).first()
      transfer_additional_info = string_domain.children( '.additional_info' ).first()
      transfer_additional_info.css( 'height' , getMaxOuterHeight( transfer_additional_info.children() , true ) )
      string_domain.css( 'height' , getSumOuterHeight( string_domain.children() , true ) )
      #
      transfer_info_height = Math.max( railway_line_code.outerHeight( true ) , string_domain.outerHeight( true ) )
      transfer_info.css( 'height' , transfer_info_height )
      return
    return
  return