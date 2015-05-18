#-------------------------------- Google Map の処理

class GoogleMapInStationFacility

  constructor: ( @domain = $( 'iframe#map' ) ) ->

  ul_exits = (v) ->
    return $( 'ul#exits' )

  width_of_domain = (v) ->
    p = new DomainsCommonProcessor( $( '#main_content_wide , #main_content_center' ) )
    return p.max_width()

  width_of_ul_exits = (v) ->
    return ul_exits(v).outerWidth( true )

  height_of_ul_exits = (v) ->
    return ul_exits(v).height()

  border_width_of_map = (v) ->
    return parseInt( v.domain.css( 'border-width' ) , 10 )

  width_of_google_map = (v) ->
    return width_of_domain(v) - ( width_of_ul_exits(v) + border_width_of_map(v) * 2 )

  height_of_google_map = (v) ->
    return height_of_ul_exits(v)

  process: ->
    @domain.css( 'width' , width_of_google_map(@) )
    @domain.css( 'height' , height_of_google_map(@) )

window.GoogleMapInStationFacility = GoogleMapInStationFacility