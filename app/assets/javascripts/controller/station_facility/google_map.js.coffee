#-------------------------------- Google Map の処理

class GoogleMapInStationFacility

  # constructor: ( @domain = $( 'iframe#map' ) ) ->
  constructor: ( @domain = $( '#map_canvas' ) ) ->
  
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

  li_domains_of_map_without_link_to_large_size = (v) ->
    return map_handler(v)
      .children( ".links_and_current_position" )
      .children( "ul#links_of_map" )
      .children( "li.link_of_map" )
      .filter( '.to_center_of_station , .to_current_position' )
  
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
    obj =
      lat: parseFloat( dom.attr( "data-geo-lat" ) )
      lng: parseFloat( dom.attr( "data-geo-lng" ) )
    # console.log obj
    return obj

  initialize_map: () ->
    # console.log 'GoogleMapInStationFacility\#initialize_map'
    if has_map_canvas(@)
      google.maps.event.addDomListener( window , 'load' , map_init_function(@) )
      google.maps.event.addDomListener( window , 'page:change' , map_init_function(@) )

    return
  
  map_init_function = (v) ->
    _default_map_options = default_map_options(v)
    set_current_map_info( v , _default_map_options.center.lat , _default_map_options.center.lng , _default_map_options.zoom )
    v.in_li_domains = false

    map = new google.maps.Map( map_canvas_element(v) , _default_map_options )

    google.maps.event.addListener( map , 'idle', event_when_center_changed( v , map ) )
    google.maps.event.addListenerOnce( map , 'idle', set_hover_and_click_event_to_li_domain_groups( v , map ) )
    return


  set_current_map_info = ( v , lat , lng , zoom ) ->
    v.current_map_info =
      lat: lat
      lng: lng
      zoom: zoom
    return

  event_when_center_changed = ( v , map ) ->
    f = ->
      set_link_for_open_large_size( v , map )
      return
    return f

  set_link_for_open_large_size = ( v , map ) ->
    center = map.getCenter()
    zoom = map.getZoom()
    # console.log center

    # console.log 'GoogleMapInStationFacility\#set_link_for_open_large_size'
    # console.log "lat: #{ center.lat() } / lng: #{ center.lng() }"

    # # console.log "center: #{ center }"
    # # console.log center

    li_domain = $( 'li#open_large_size' )
    # li_domain.attr( 'data-geo-lat' , center.lat() ).attr( 'data-geo-lng' , center.lng() )
    li_domain.children( 'a' ).attr( 'href' , "https://www.google.co.jp/maps/@#{ center.lat() },#{ center.lng() },#{ zoom }z" )

    return

  #--------

  set_hover_and_click_event_to_li_domain_groups = ( v , map ) ->
    f = ->
      _li_domains_of_map_without_link_to_large_size = li_domains_of_map_without_link_to_large_size(v)
      _li_domains_of_points = li_domains_of_points(v)
      # console.log 'set_hover_and_click_event_to_li_domain_groups - begin'
      if has_map_handler(v)
        # console.log 'has_map_handler'
        set_hover_and_click_event_to_each_li_domain_group( v , map , _li_domains_of_map_without_link_to_large_size , default_zoom_size(v) - 1 )
        set_tooltips( v , _li_domains_of_map_without_link_to_large_size )
      if has_ul_exits(v)
        # console.log 'has_ul_exits'
        set_hover_and_click_event_to_each_li_domain_group( v , map , _li_domains_of_points , default_zoom_size(v) + 3 )
        set_tooltips( v , _li_domains_of_points )
        set_mouseleave_event_to_ul_exits(v)
      # console.log 'set_hover_and_click_event_to_li_domain_groups - end'
    return f

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
  
  set_mouseleave_event_to_ul_exits = (v) ->
    ul_exits(v).on
      "mouseleave": ->
        # console.log 'mouseleave_of_group'
        leave_li_domains(v)
        return
    return
  
  sleep_time_when_hover_on = (v) ->
    return 1000 # [ms]

  event_when_mouseenter = ( v , map , _domain , zoom_min ) ->
    _sleep_time_when_hover_on = sleep_time_when_hover_on(v)

    f = ->
      # console.log 'event_when_mouseenter - begin'
      set_current_map_info( v , map.getCenter().lat() , map.getCenter().lng() , map.getZoom() )
      move_map( v , map , _domain , zoom_min )
      # console.log 'event_when_mouseenter - end'
      return

    # 外の領域から来たとき
    if from_out_of_li_domains(v)
      # delay を設定
      enter_li_domains(v)
      timeout_event = setTimeout( f , sleep_time_when_hover_on )
      _domain.data( 'timeout' , timeout_event )
    #
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
    set_current_map_info( v , map.getCenter().lat() , map.getCenter().lng() , map.getZoom() )
    # console.log 'event_when_click - end'
    return

  move_map = ( v , map , li_domain , zoom_min ) ->
    # console.log 'move_map'
    # console.log li_domain
    # console.log map
    # console.log map.getCenter().lat()
    # console.log map.getCenter().lng()
    # console.log map.getZoom()

    lat_lng_move_to = get_geo_attr( v , li_domain )

    # console.log lat_lng_move_to

    map.panTo( lat_lng_move_to )
    if v.current_map_info.zoom < zoom_min
      map.setZoom( zoom_min )
    return

  reset_map = ( v , map ) ->
    lat_lng_move_to =
      lat: v.current_map_info.lat
      lng: v.current_map_info.lng

    # console.log v.current_map_info
    # console.log lat_lng_move_to

    map.panTo( lat_lng_move_to )
    map.setZoom( v.current_map_info.zoom )
    return

  from_out_of_li_domains = (v) ->
    return !( v.in_li_domains )

  enter_li_domains = (v) ->
    v.in_li_domains = true
    return

  leave_li_domains = (v) ->
    v.in_li_domains = false
    return

  set_tooltips = ( v , domains ) ->
    _sleep_time_when_hover_on = sleep_time_when_hover_on(v)
    option =
      potision:
        my: "left top"
        at: "left bottom"
      show:
        effect: "slideDown"
        delay: _sleep_time_when_hover_on
      content: "<span class='in_tooltip text_ja'>クリックで地図の表示を固定</span>"
      items: '[class]'
      track: false
    # console.log 'set_tooltips'
    # console.log domains
    domains.tooltip( option )
    return

window.GoogleMapInStationFacility = GoogleMapInStationFacility
