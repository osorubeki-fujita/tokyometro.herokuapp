class StationFacility

  constructor: ->
    @station_facility_title = $( '#station_facility_title' )
    @tab_contents = $( '#platform_info_tab_contents' )
    return

  in_station_facility_station_page = (v) ->
    return ( v.station_facility_title.length > 0 )

  # 各路線のプラットホーム情報の table
  tables_of_platform_info_tab_contents = (v) ->
    return v.tab_contents.find( 'table.platform_info' )

  platform_info_tab_contents = (v) ->
    tab_ul_processor = new StationFacilityPlatformInfoTabUl()
    return tab_ul_processor.li_contents()
  
  content_headers_in_station_facility_page = (v) ->
    return $( '#tokyo_metro_railway_lines , #other_railway_lines , #links_to_station_info_pages , #station_facility_platform_infos , #station_facility_infos' )
      .children( '.content_header' )

  process: ->
    if in_station_facility_station_page(@)
      process_content_headers(@)
      process_point_ul(@)
      process_google_maps(@)
      process_platform_info_tabs(@)

      process_tables_of_platform_info_tab_contents(@)

      @.change_platform_info_tabs()

      process_barrier_free_facility_infos(@)
    return

  process_content_headers = (v) ->
    p = new ContentHeaderProcessor( content_headers_in_station_facility_page(v) )
    p.process()
    return

  process_point_ul = (v) ->
    p = new StationFacilityPointUl()
    p.process()
    return

  process_google_maps = (v) ->
    p = new GoogleMapsInStationFacility()
    p.process()
    return

  #-------- プラットホーム情報のタブとその内容の処理・初期化

  process_platform_info_tabs = (v) ->
    tab_ul_processor = new StationFacilityPlatformInfoTabUl()
    tab_ul_processor.process()
    return

  process_tables_of_platform_info_tab_contents = (v) ->
    # console.log 'length: ' + tables_of_platform_info_tab_contents(v).length
    tables_of_platform_info_tab_contents(v).each ->
      table = new StationFacilityPlatformInfoTable( $(@) )
      table.process()
      return
    return

  #-------- バリアフリー情報の処理
  process_barrier_free_facility_infos = (v) ->
    b = new StationFacilityBarrierFreeFacilityInfos()
    b.process()
    return

  change_platform_info_tabs: ->
    # process_tables_of_platform_info_tab_contents(@)

    t = new StationFacilityPlatformInfoTabsAndContents( platform_info_tab_contents(@) )
    t.initialize_platform_infos()
    return

window.StationFacility = StationFacility
