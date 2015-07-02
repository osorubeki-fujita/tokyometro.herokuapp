class DomainsCommonProcessor
  constructor: ( @domains ) ->

  ceil = ( len ) =>
    return Math.ceil( len )

  max_outer_width: ( setting = false ) ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).outerWidth( setting ) )
      return
    return Math.ceil( len )

  max_width: ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).width() )
      return
    return Math.ceil( len )

  max_inner_width: ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).innerWidth() )
      return
    return Math.ceil( len )

  max_outer_height: ( setting = false ) ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).outerHeight( setting ) )
      return
    return Math.ceil( len )

  max_height: ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).height() )
      return
    return Math.ceil( len )

  max_inner_height: ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , $( this ).innerHeight() )
      return
    return Math.ceil( len )

  sum_outer_width: ( setting ) ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).outerWidth( setting )
      return
    return Math.ceil( len )

  sum_width: ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).width()
      return
    return Math.ceil( len )

  sum_inner_width: ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).innerWidth()
      return
    return Math.ceil( len )

  sum_outer_height: ( setting ) ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).outerHeight( setting )
      return
    return Math.ceil( len )

  sum_height: ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).height()
      return
    return Math.ceil( len )

  sum_inner_height: ->
    len = 0
    $.each @domains , ->
      len = len + $( this ).innerHeight()
      return
    return Math.ceil( len )

  max_border_width: ->
    len = 0
    $.each @domains , ->
      len = Math.max( len , parseInt( $( this ).css( 'border-width' ) , 10 ) )
      return
    return Math.ceil( len )

  set_all_of_uniform_width_to_max: ->
    _w = @.max_outer_width( false )
    @.set_css_attribute( 'width' , _w )
    return

  set_all_of_uniform_height_to_max: ->
    _h = @.max_outer_height( false )
    # console.log _h
    @.set_css_attribute( 'height' , _h )
    return

  set_css_attribute: ( css_attribute , css_value ) ->
    $.each @domains , ->
      $( this ).css( css_attribute , css_value )
      return
    return

window.DomainsCommonProcessor = DomainsCommonProcessor