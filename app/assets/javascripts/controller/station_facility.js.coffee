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

  process: ->
    if in_station_facility_station_page(@)
      process_point_ul(@)
      process_google_map(@)
      process_platform_infos(@)
      process_barrier_free_facility_infos(@)
    return

  process_point_ul = (v) ->
    p = new StationFacilityPointUl()
    p.process()
    return

  process_google_map = (v) ->
    p = new GoogleMapInStationFacility()
    p.process()
    return

  #-------- プラットホーム情報のタブとその内容の処理・初期化
  process_platform_infos = (v) ->
    process_tables_of_platform_info_tab_contents(v)
    process_platform_info_tabs(v)
    return

  process_tables_of_platform_info_tab_contents = (v) ->
    tables_of_platform_info_tab_contents(v).each ->
      table = new StationFacilityPlatformInfoTable( $(@) )
      table.process()
      return
    return

  process_platform_info_tabs = (v) ->
    tab_ul_processor = new StationFacilityPlatformInfoTabUl()
    tab_ul_processor.process()

    platform_info_tabs = tab_ul_processor.li_contents()
    t = new StationFacilityPlatformInfoTabsAndContents( platform_info_tabs )
    t.initialize_platform_infos()
    return

  #-------- バリアフリー情報の処理
  process_barrier_free_facility_infos = (v) ->
    b = new StationFacilityBarrierFreeFacilityInfos()
    b.process()
    return

window.StationFacility = StationFacility