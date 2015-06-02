#-------------------------------- Google Map の処理

class GoogleMapInStationFacility

  # constructor: ( @domain = $( 'iframe#map' ) ) ->
  constructor: ( @domain = $( '#map_canvas' ) ) ->

  has_map_canvas = (v) ->
    return v.domain.length > 0
   has_map_handler = (v) ->
    map_handler = $( "#map_handler" )
    return map_handler.length > 0

  ul_exits = (v) ->
    return $( 'ul#exits' )

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
    return width_of_exits_and_map(v) - ( width_of_ul_exits(v) + border_width_of_map(v) * 2 )

  height_of_map_canvas = (v) ->
    return height_of_ul_exits(v)

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

  default_center_position_of_map = (v) ->
    obj =
      lat: parseFloat( v.domain.attr( "data-geo-lat" ) )
      lng: parseFloat( v.domain.attr( "data-geo-lng" ) )
    # console.log obj
    return obj
  
 efault_zoom_size = (v) ->
    return parseInt( v.domain.attr( "data-zoom" ) , 10 )

  default_map_options = (v) ->
    obj =
      center: default_center_position_of_map(v)
      zoom: default_zoom_size(v)
    # console.log obj
    return obj
  
  m_canvas_element = (v) ->
    return document.getElementById( "map_canvas" )

  initialize_map: ->
    console.log 'GoogleMapInStationFacility\#initialize_map'
    if has_map_canvas(@)
      _default_map_options = default_map_options(@)

      @before_hover_on =
        lat: _default_map_options.center.lat
        lng: _default_map_options.center.lng
        zoom: _default_map_options.zoom

      init_function = ->
        map = new google.maps.Map( map_canvas_element(@) , _default_map_options )

        # google.maps.event.addListenerOnce( map , 'idle', event_when_center_changed( @ , map ) )
        # google.maps.event.addListener( map , 'center_changed', event_when_center_changed( @ , map ) )
        google.maps.event.addListener( map , 'idle', event_when_center_changed( @ , map ) )
        google.maps.event.addListenerOnce( map , 'idle', set_hover_event_to_li_domains_of_map( @ , map ) )
        return

      google.maps.event.addDomListener( window , 'load' , init_function )
      google.maps.event.addDomListener( window , 'page:change' , init_function )
    return

  event_when_center_changed = ( v , map ) ->
    # console.log 'GoogleMapInStationFacility\#event_when_center_changed'
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

  set_hover_event_to_li_domains_of_map = ( v , map ) ->
    f = ->
      # console.log 'set_hover_event_to_li_domains_of_map 1'
      if has_map_handler(v)
        # console.log li_domains_of_map_without_link_to_large_size(@)
        li_domains_of_map_without_link_to_large_size(@).each ->
          _domain = $(@)
          # console.log $(@)
          _domain.hover( hover_on( v , map , _domain ) , hover_off( v , map ) )
          _domain.click( hover_on( v , map , _domain ) )
          return
      # console.log 'set_hover_event_to_li_domains_of_map 2'
    return f

  li_domains_of_map_without_link_to_large_size = (v) ->
    return $( "#map_handler" )
      .children( ".links_and_current_position" )
      .children( "ul#links_of_map" )
      .children( "li.link_of_map" )
      .filter( '.to_center_of_station , .to_current_position' )

  # google_map_object = (v) ->
    # map = new google.maps.Map( map_canvas_element(v) )
    # return map

  hover_on = ( v , map , li_domain ) ->
    # console.log 'hover_on'
    # console.log li_domain
    # console.log map
    # console.log map.getCenter().lat()
    # console.log map.getCenter().lng()
    # console.log map.getZoom()

    f = ->
      v.before_hover_on =
        lat: map.getCenter().lat()
        lng: map.getCenter().lng()
        zoom: map.getZoom()

      # console.log v.before_hover_on

      lat_lng_move_to =
        lat: parseFloat( li_domain.attr( 'data-geo-lat' ) )
        lng: parseFloat( li_domain.attr( 'data-geo-lng' ) )

      # console.log lat_lng_move_to

      zoom_min = default_zoom_size(v) - 1
      map.panTo( lat_lng_move_to )
      if v.before_hover_on.zoom < zoom_min
        map.setZoom( zoom_min )
      return
    return f

  hover_off = ( v , map ) ->
    # console.log 'hover_off'
    # console.log v.before_hover_on

    f = ->
      lat_lng_move_to =
        lat: v.before_hover_on.lat
        lng: v.before_hover_on.lng

      # console.log lat_lng_move_to

      map.panTo( lat_lng_move_to )
      map.setZoom( v.before_hover_on.zoom )
      return
    return f

window.GoogleMapInStationFacility = GoogleMapInStationFacility
