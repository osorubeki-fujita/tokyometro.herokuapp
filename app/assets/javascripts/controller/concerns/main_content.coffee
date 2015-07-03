class MainContentCenter

  constructor: ( @domain = $( '#main_content_center' ) ) ->

  process: ->
    if @domain.length > 0
      @domain.css( 'width' , width_of_domain(@) )
    return

  width_of_domain = (v) ->
    return $( '#contents' ).width() - $( '#left_contents' ).outerWidth( true ) - $( '#right_contents' ).outerWidth( true )

window.MainContentCenter = MainContentCenter

class MainContentWide

  constructor: ( @domain = $( '#main_content_wide' ) ) ->

  process: ->
    if @domain.length > 0
      @domain.css( 'width' , width_of_domain(@) )
    return

  width_of_domain = (v) ->
    return $( '#contents' ).width() - $( '#left_contents' ).outerWidth( true )

window.MainContentWide = MainContentWide
