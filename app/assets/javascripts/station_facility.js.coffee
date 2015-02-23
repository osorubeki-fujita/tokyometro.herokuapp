processStationFacility = ->
  processRailwayLinesRelatedToThisStation()
  processStationFacilityPlatformInfoTabs()
  processStationFacilityPlatformInfos()
  processStationFacilityInfos()
  initializeStationFacilityPlatformInfoTab()
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
    # 乗換情報の処理
    processStationFacilityPlatformInfosTransferInfos( table.find( '.transfer_info' ) )
    return
  return

processStationFacilityPlatformInfosTransferInfos = ( transfer_infos ) ->
  transfer_infos.each ->
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

#--------------------------------
# プラットホーム情報の処理
#--------------------------------

#-------- stationFacilityPlatformInfoTabProcessor

class stationFacilityPlatformInfoTabProcessor
  constructor: ( @anchor , @tab_id ) ->
  is_included_in: ( contents ) ->
    return contents.children( @tab_id ).length == 1
  is_not_included_in: ( contents ) ->
    return !( is_included_in( contents ) )

#-------- changeStationFacilityPlatformInfoTab

changeStationFacilityPlatformInfoTab = ( contents , processor , change_location = true ) ->
  contents.each ->
    unless $( this ).attr( 'id' ) == processor.tab_id
      $( this ).css( 'display' , 'none' )
    else
      $( this ).css( 'display' , 'block' )

  if change_location
    window.location.hash = processor.anchor

  return

#-------- changeStationFacilityPlatformInfoTabByPageLink

changeStationFacilityPlatformInfoTabByPageLink = ( tab_id , change_location = true ) ->
  contents = platformInfoTabs()
  # alert( tab_id )
  anchor_name = anchorNameOfStationFacilityPlatformInfoTab( tab_id )
  # alert( anchor_name )
  processor = new stationFacilityPlatformInfoTabProcessor( anchor_name , tab_id )
  changeStationFacilityPlatformInfoTab( contents , processor , change_location )
  return

window.changeStationFacilityPlatformInfoTabByPageLink = changeStationFacilityPlatformInfoTabByPageLink

#-------- anchorNameOfStationFacilityPlatformInfoTab

anchorNameOfStationFacilityPlatformInfoTab = ( tab_id ) ->
  return tab_id.replace( /\#?platform_info_/ , "" )

#-------- changeStationFacilityPlatformInfoTabToFirst
#-------- 最初のタブを表示

changeStationFacilityPlatformInfoTabToFirst = ( contents , change_location ) ->
  first_tab_id = contents.first().attr( 'id' )
  anchor_name = anchorNameOfStationFacilityPlatformInfoTab( first_tab_id )
  processor = new stationFacilityPlatformInfoTabProcessor( anchor_name , first_tab_id )
  changeStationFacilityPlatformInfoTab( contents , processor , change_location )
  return

#-------- initializeStationFacilityPlatformInfoTab
#-------- タブの初期化

initializeStationFacilityPlatformInfoTab = ->
  contents = platformInfoTabs()
  if contents.length > 0
    anchor_name = window.location.hash.replace( "#" , "" )
    #-------- アンカーが指定されていない場合
    if anchor_name == ''
      #-- 最初のタブを表示
      changeStationFacilityPlatformInfoTabToFirst( contents , false )
    #-------- アンカーが指定されている場合
    else
      processor = new stationFacilityPlatformInfoTabProcessor( anchor_name , '#platform_info_' + anchor_name )
      #---- アンカーが正しく指定されている場合
      if processor.is_included_in( contents )
        #-- アンカーに適合するタブを表示
        changeStationFacilityPlatformInfoTab( contents , processor , false )
      #---- アンカーが正しく指定されていない場合
      else
        #-- 最初のタブを表示
        changeStationFacilityPlatformInfoTabToFirst( contents , true )

  return

#-------- platformInfoTabs
#-------- タブのリスト

platformInfoTabs = ->
  return $( '#platform_info_tab_contents' ).find( 'li.platform_info_tab_content' )