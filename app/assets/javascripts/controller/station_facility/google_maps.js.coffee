#-------------------------------- Google Map の処理

class GoogleMapsInStationFacility

  # constructor: ( @domain = $( 'iframe#map' ) ) ->
  constructor: ( @domain = $( '#map_canvas' ) ) ->
    @sleep_time_when_hover_on = 1000 # [ms]

  #---- 地図に関連する領域

  map_canvas_element = (v) ->
    return document.getElementById( "map_canvas" )

  ul_exits = (v) ->
    return $( 'ul#exits' )

  li_domains_of_points = (v) ->
    return ul_exits(v)
      .children( 'li.point' )

  map_handler = (v) ->
    return $( "#map_handler" )

  links_to_maps = (v) ->
    return map_handler(v)
      .children( ".links_and_current_position" )
      .children( "ul#links_to_maps" )

  li_domains_of_map_without_link_to_large_size = (v) ->
    return links_to_maps(v)
      .children( "li.link_to_map" )
      .filter( '#link_to_map_on_the_center_of_station , #link_to_map_of_current_position' )

  #---- 領域の有無の判定

  has_map_canvas = (v) ->
    return v.domain.length > 0

  has_ul_exits = (v) ->
    return ul_exits(v).length > 0

  has_map_handler = (v) ->
    return map_handler(v).length > 0

  #---- 領域の属性

  width_of_exits_and_map = (v) ->
    p = new DomainsCommonProcessor( $( '#main_content_wide , #main_content_center' ) )
    return p.max_width()

  width_of_ul_exits = (v) ->
    return ul_exits(v).outerWidth( true )

  height_of_ul_exits = (v) ->
    return ul_exits(v).height()

  border_width_of_map = (v) ->
    return parseInt( v.domain.css( 'border-width' ) , 10 )

  width_of_map_canvas = (v) ->
    return width_of_exits_and_map(v) - ( width_of_ul_exits(v) + border_width_of_map(v) )

  height_of_map_canvas = (v) ->
    return height_of_ul_exits(v)

  #-------- 一般の処理

  process: ->
    if has_map_canvas(@)
      set_width_of_map_canvas(@)
      set_height_of_map_canvas(@)
    return

  set_width_of_map_canvas = (v) ->
    v.domain.css( 'width' , width_of_map_canvas(v) )
    return

  set_height_of_map_canvas = (v) ->
    v.domain.css( 'height' , height_of_map_canvas(v) )
    return

  #-------- Google Map

  default_center_position_of_map = (v) ->
    return get_geo_attr( v , v.domain )

  default_zoom_size = (v) ->
    return parseInt( v.domain.attr( "data-zoom" ) , 10 )

  default_map_options = (v) ->
    obj =
      center: default_center_position_of_map(v)
      zoom: default_zoom_size(v)
    # console.log obj
    return obj

  get_geo_attr = ( v , dom ) ->
    geo_info = new GeoInfoOnGoogleMaps( dom )
    return geo_info.to_obj()

  initialize_map: () ->
    # console.log 'GoogleMapsInStationFacility\#initialize_map'
    if has_map_canvas(@)
      google.maps.event.addDomListener( window , 'load' , map_init_function(@) )
      google.maps.event.addDomListener( window , 'page:change' , map_init_function(@) )
    return

  #-------- Google Maps の関数 (0.1) 現在表示されている地図の情報をセットする関数
  set_current_map_info = ( v , center , zoom ) ->
    v.current_map_info =
      center: center
      zoom: zoom
    return

  #-------- Google Maps の関数 (0.2) 現在表示されている地図の中心位置を取得しオブジェクトを返す関数
  current_center_position_of_map = ( v , map ) ->
    center =
      lat: map.getCenter().lat()
      lng: map.getCenter().lng()
    return center

  enter_li_domains = (v) ->
    # console.log 'enter_li_domains'
    v.in_li_domains = true
    return

  leave_li_domains = (v) ->
    # console.log 'leave_li_domains'
    v.in_li_domains = false
    return

  from_out_of_li_domains = (v) ->
    return !( v.in_li_domains )

  markers = (v) ->
    return [ v.markers_of_exits , v.marker_of_center ]

  #-------- Google Maps の関数 (1) 初期化時に実行する関数

  # 地図表示時、最初に実行される関数
  map_init_function = (v) ->
    init_fundamental_infos(v)

    map = new google.maps.Map( map_canvas_element(v) , default_map_options(v) )
    google.maps.event.addListener( map , 'idle', event_when_center_changed( v , map ) )
    google.maps.event.addListenerOnce( map , 'idle', event_when_first_load_completed( v , map ) )
    return

  #-------- 基礎情報を初期化する関数
  init_fundamental_infos = (v) ->
    init_markers(v)
    init_current_map_info(v)
    init_current_mouse_position(v)
    return

  #-------- Google Maps の関数 (1.1) マーカーの情報を初期化する関数
  init_markers = (v) ->
    v.markers_of_exits = new GeoMarkersOnGoogleMaps( li_domains_of_points(v) , { min: default_zoom_size(v) + 1 } )
    v.marker_of_center = new GeoMarkersOnGoogleMaps( v.domain , { max: default_zoom_size(v) } , true )
    return

  #-------- Google Maps の関数 (1.2) 現在表示されている地図の情報を初期化する関数
  init_current_map_info = (v) ->
    d = default_map_options(v)
    set_current_map_info( v , d.center , d.zoom )
    return

  #-------- Google Maps の関数 (1.3) マウスの位置情報を初期化する関数
  init_current_mouse_position = (v) ->
    v.in_li_domains = false
    return

  #--------

  #-------- Google Maps の関数 (2) 地図の中心が変更されたときに実行される関数
  event_when_center_changed = ( v , map ) ->
    f = ->
      set_link_for_opening_large_size_map( v , map )
      change_display_settings_of_markers( v , map )
      return
    return f

  #-------- Google Maps の関数 (2.1) 大きい window で地図を開くためのリンクを初期化・更新する関数
  set_link_for_opening_large_size_map = ( v , map ) ->
    center = map.getCenter()
    zoom = map.getZoom()
    $( 'li#open_large_size_map' )
      .children( 'a' )
      .attr( 'href' , "https://www.google.co.jp/maps/@#{ center.lat() },#{ center.lng() },#{ zoom }z" )
    return

  #--------

  #-------- Google Maps の関数 (3) 最初のロードが完了したときに実行される関数
  event_when_first_load_completed = ( v , map ) ->
    f = ->

      # console.log 'event_when_first_load_completed - begin'
      if has_map_handler(v)
        # console.log 'has_map_handler'
        event_for_each_link_group_when_first_load_completed( v , map , links_to_maps(v) , li_domains_of_map_without_link_to_large_size(v) , default_zoom_size(v) - 1 )

      if has_ul_exits(v)
        # console.log 'has_ul_exits'
        event_for_each_link_group_when_first_load_completed( v , map , ul_exits(v) , li_domains_of_points(v) , default_zoom_size(v) + 3 )
        init_display_settings_of_markers( v , map )

      # console.log 'event_when_first_load_completed - end'
    return f

  event_for_each_link_group_when_first_load_completed = ( v , map , ul_domain , li_domains , zoom_min ) ->
    set_hover_and_click_event_to_each_li_domain_group( v , map , li_domains , zoom_min )
    set_tooltips( v , li_domains )
    set_mouseleave_event( v , ul_domain )
    return

  #-------- Google Maps の関数 (3.1) リンク領域にマウスオーバー・クリック時のイベントを登録する関数
  set_hover_and_click_event_to_each_li_domain_group = ( v , map , group , zoom_min ) ->
    group.each ->
      _domain = $(@)
      _domain.on
        # .on 'hover' は使用不可
        "mouseenter": ->
          event_when_mouseenter( v , map , _domain , zoom_min )
          return
        "mouseleave": ->
          event_when_mouseleave( v , map , _domain )
          return
        "click": ->
          event_when_click( v , map , _domain , zoom_min )
          return
      return
    return

  event_when_mouseenter = ( v , map , _domain , zoom_min ) ->

    #-------- 処理の内容
    f = ->
      # console.log 'event_when_mouseenter - begin'
      set_current_map_info( v , current_center_position_of_map( v , map ) , map.getZoom() )
      move_map( v , map , _domain , zoom_min )
      # console.log 'event_when_mouseenter - end'
      return

    # 外の領域から来たとき
    if from_out_of_li_domains(v)
      # delay を設定
      enter_li_domains(v)
      # console.log 'sleep_time_when_hover_on: ' + v.sleep_time_when_hover_on

      timeout_event = setTimeout( f , v.sleep_time_when_hover_on )
      _domain.data( 'timeout' , timeout_event )

      # setTimeout( f , v.sleep_time_when_hover_on )

      # f.call(@)

    # リンク領域内部の移動のとき
    else
      f.call(@)
    return

  event_when_mouseleave = ( v , map , _domain ) ->
    # console.log 'event_when_mouseleave - begin'

    clearTimeout( _domain.data( 'timeout' ) )
    reset_map( v , map )
    # console.log 'event_when_mouseleave - end'
    return

  event_when_click = ( v , map , _domain , zoom_min ) ->
    # console.log 'event_when_click - begin'
    clearTimeout( _domain.data( 'timeout' ) )
    move_map( v , map , _domain , zoom_min )
    set_current_map_info( v , current_center_position_of_map( v , map ) , map.getZoom() )
    # console.log 'event_when_click - end'
    return

  move_map = ( v , map , li_domain , zoom_min ) ->
    map.panTo( get_geo_attr( v , li_domain ) )
    if v.current_map_info.zoom < zoom_min
      map.setZoom( zoom_min )
    return

  reset_map = ( v , map ) ->
    map.panTo( v.current_map_info.center )
    map.setZoom( v.current_map_info.zoom )
    return

  #-------- Google Maps の関数 (3.2) リンク領域に tooltip を設定する関数
  set_tooltips = ( v , domains ) ->
    option =
      potision:
        my: "left top"
        at: "left bottom"
      show:
        effect: "slideDown"
        delay: v.sleep_time_when_hover_on
      content: "<span class='text_ja'>クリックで地図の表示を固定</span>"
      items: '[class]'
      track: false
      tooltipClass: 'map_link'
    domains.tooltip( option )
    return

  #-------- Google Maps の関数 (3.3) リンクのリストの領域からマウスが出たときのイベントを登録する関数
  set_mouseleave_event = ( v , ul ) ->
    ul.on
      'mouseleave': ->
        # console.log 'mouseleave_of_group'
        leave_li_domains(v)
        return
    return

  # マーカーの表示設定を変更する関数
  change_display_settings_of_markers = ( v , map ) ->
    # console.log 'change_display_settings_of_markers'
    for marker_group in markers(v)
      marker_group.refresh( map )
    return

  init_display_settings_of_markers = ( v , map ) ->
    # console.log 'init_display_settings_of_markers'
    for marker_group in markers(v)
      marker_group.init( map )
    return

window.GoogleMapsInStationFacility = GoogleMapsInStationFacility

class GeoMarkersOnGoogleMaps

  #-------- 地物情報のリストを初期化
  constructor: ( points , size_settings , station_main_marker ) ->
    ary = []
    # console.log 'GeoMarkersOnGoogleMaps\#constructor'
    for point in points
      geo_info = new GeoInfoOnGoogleMaps( $( point ) , station_main_marker )
      ary.push( geo_info.to_marker_obj() )
    @markers = ary
    @size_settings = size_settings
    @display = false

  refresh: ( map , force ) ->
    if to_display( @ , map )
      if !( now_displayed(@) ) or force
        display_markers_of_exits( @ , map )
    else
      if now_displayed(@) or force
        hide_markers_of_exits(@)
    return

  init: ( map ) ->
    if to_display( @ , map )
      display_markers_of_exits( @ , map )
    else
      hide_markers_of_exits(@)
    return

  to_display = ( v , map ) ->
    if v.size_settings.min? and v.size_settings.max?
      return ( v.size_settings.min <= map.getZoom() ) and ( map.getZoom() <= v.size_settings.max )
    else if v.size_settings.min?
      return v.size_settings.min <= map.getZoom()
    else if v.size_settings.max?
      return map.getZoom() <= v.size_settings.max
    else
      return true
    return

  now_displayed = (v) ->
    return v.display

  display_markers_of_exits = ( v , map ) ->
    set_marker_of_exits( v , map )
    v.display = true
    return

  hide_markers_of_exits = ( v ) ->
    set_marker_of_exits( v , null )
    v.display = false
    return

  # マーカーに地図を適用する関数
  set_marker_of_exits = ( v , map ) ->
    # console.log map
    for marker in v.markers
      # console.log marker
      marker.setMap( map )
    return

class GeoInfoOnGoogleMaps

  constructor: ( @domain , @station_main_marker = false ) ->
    # console.log @domain

  to_obj: ->
    # console.log 'to_obj'
    obj =
      lat: lat(@)
      lng: lng(@)
    return obj

  to_latlng_obj: ->
    # console.log 'to_latlng_obj'
    obj = new google.maps.LatLng( lat(@) , lng(@) )
    return obj

  to_marker_obj: ->
    marker = new google.maps.Marker( marker_option(@) )
    return marker

  marker_option = (v) ->
    obj =
      position: v.to_latlng_obj()
      title: marker_title(v)
      icon: marker_icon(v)
    return obj

  marker_title = (v) ->
    if v.station_main_marker
      map_canvas = new MapCanvas()
      return map_canvas.to_title_on_google_maps_as_station_main_marker()
    else
      str_ja = "出入口"
      str_en = "Entrance/Exit"
      if has_code_info(v)
        str_ja += " #{ code_info(v) }"
        str_en += " #{ code_info(v) }"
      if has_elevator(v)
        str_ja += "（エレベーターあり）"
        str_en += " [with elevator]"
      if close(v)
        str_ja += "【現在閉鎖中】"
        str_en += " [Now closed]"
      return "#{ str_ja } #{ str_en }"
    return

  marker_icon = (v) ->
    if v.station_main_marker
      return null
    else
      obj =
        path: 'M -4 -4 L 4 -4 L 4 4 L -4 4 z'
        fillOpacity: 0.9
        scale: 1
        strokeOpacity: 1
        strokeWeight: 0.5
      if open(v)
        if has_elevator(v)
          obj.fillColor = '#6c2b30'
          obj.strokeColor = '#6b1920'
        else
          obj.fillColor = '#f7e27c'
          obj.strokeColor = '#ed5b00'
      else if close(v)
        obj.fillColor = 'gray'
        obj.strokeColor = 'black'
      return obj
    return

  lat = (v) ->
    return parseFloat( v.domain.attr( "data-geo_lat" ) )

  lng = (v) ->
    return parseFloat( v.domain.attr( "data-geo_lng" ) )

  has_elevator = (v) ->
    return v.domain.children().hasClass( 'elevator' )

  open = (v) ->
    return v.domain.hasClass( 'open' )

  close = (v) ->
    return v.domain.hasClass( 'close' )

  has_code_info = (v) ->
    return v.domain.children( '.code.text_en' ).length > 0

  code_info = (v) ->
    return v.domain.children( '.code.text_en' ).html()

class MapCanvas

  constructor: ( @domain = $( '#map_canvas' ) ) ->

  station_codes = (v) ->
    return v.domain.attr( 'data-station_codes' )

  station_name_ja = (v) ->
    return v.domain.attr( 'data-station_name_ja' )

  station_name_hira = (v) ->
    return v.domain.attr( 'data-station_name_hira' )

  station_name_en = (v) ->
    return v.domain.attr( 'data-station_name_en' )

  to_title_on_google_maps_as_station_main_marker: ->
    return "[#{ station_codes(@) }] #{ station_name_ja(@) }（#{ station_name_hira(@) } #{ station_name_en(@) }）"
