#-------------------------------- Google Map の処理

class GoogleMapInStationFacility

  # constructor: ( @domain = $( 'iframe#map' ) ) ->
  constructor: ( @domain = $( '#map_canvas' ) ) ->

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
    set_width_of_map_canvas(@)
    set_height_of_map_canvas(@)
    initialize_map(@)
    return

  set_width_of_map_canvas = (v) ->
    v.domain.css( 'width' , width_of_map_canvas(v) )
    return

  set_height_of_map_canvas = (v) ->
    v.domain.css( 'height' , height_of_map_canvas(v) )
    return

  center_of_map = (v) ->
    obj =
      lat: parseFloat( v.domain.attr( "data-geo-lat" ) )
      lng: parseFloat( v.domain.attr( "data-geo-lng" ) )
    # console.log obj
    return obj
  
  default_zoom_size = (v) ->
    return parseInt( v.domain.attr( "data-zoom" ) , 10 )

  map_options_on_initialize = (v) ->
    obj =
      center: center_of_map(v)
      zoom: default_zoom_size(v)
    # console.log obj
    return obj

  initialize_map = (v) ->
    # console.log 'GoogleMapInStationFacility\#initialize_map'
    init_function = ->
      mapOptions = map_options_on_initialize(v)
      map = new google.maps.Map( document.getElementById( "map_canvas" ) , mapOptions )
      center = mapOptions.center

      # google.maps.event.addListenerOnce( map , 'idle', event_when_center_changed( v , map ) )
      # google.maps.event.addListener( map , 'center_changed', event_when_center_changed( v , map ) )
      google.maps.event.addListener( map , 'idle', event_when_center_changed( v , map ) )
      return

    google.maps.event.addDomListener( window , 'load' , init_function )
    return

  event_when_center_changed = ( v , map ) ->
    # console.log 'GoogleMapInStationFacility\#event_when_center_changed'
    f = ->
      center = map.getCenter()
      # console.log center
      set_link_for_open_large_size( v , center )
      return
    return f

  set_link_for_open_large_size = ( v , center ) ->
    # console.log 'GoogleMapInStationFacility\#set_link_for_open_large_size'
    # console.log "lat: #{ center.lat() } / lng: #{ center.lng() }"

    # # console.log "center: #{ center }"
    # # console.log center

    li_domain = $( 'li#open_large_size' )
    zoom = default_zoom_size(v)
    # li_domain.attr( 'data-geo-lat' , center.lat() ).attr( 'data-geo-lng' , center.lng() )
    li_domain.children( 'a' ).attr( 'href' , "https://www.google.co.jp/maps/@#{ center.lat() },#{ center.lng() },#{ zoom }z" )

    return

window.GoogleMapInStationFacility = GoogleMapInStationFacility
