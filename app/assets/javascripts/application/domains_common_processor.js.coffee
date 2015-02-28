class DomainsCommonProcessor
  constructor: ( @domains ) ->

  # max_length

  max_outer_width: ( setting = false ) ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).outerWidth( setting ) )
    return len

  max_width: ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).width() )
    return len

  max_inner_width: ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).innerWidth() )
    return len

  max_outer_height: ( setting = false ) ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).outerHeight( setting ) )
    return len

  max_height: ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).height() )
    return len

  max_inner_height: ->
    len = 0
    @domains.each ->
      len = Math.max( len , $( this ).innerHeight() )
    return len

  # sum_length

  sum_outer_width: ( setting ) ->
    len = 0
    @domains.each ->
      len = len + $( this ).outerWidth( setting )
    return len

  sum_width: ->
    len = 0
    @domains.each ->
      len = len + $( this ).width()
    return len

  sum_inner_width: ->
    len = 0
    @domains.each ->
      len = len + $( this ).innerWidth()
    return len

  sum_outer_height: ( setting ) ->
    len = 0
    @domains.each ->
      len = len + $( this ).outerHeight( setting )
    return len

  sum_height: ->
    len = 0
    @domains.each ->
      len = len + $( this ).height()
    return len

  sum_inner_height: ->
    len = 0
    @domains.each ->
      len = len + $( this ).innerHeight()
    return len

  set_all_of_uniform_width_to_max: ->
    _max_width = @.max_outer_width( false )
    @.set_css_attribute( 'width' , _max_width )
    return

  sum_all_of_uniform_height_to_max: ->
    _max_height = @.max_outer_height( false )
    @.set_css_attribute( 'height' , _max_height )
    return

  set_css_attribute: ( css_attribute , css_value ) ->
    @domains.each ->
      $( this ).css( css_attribute , css_value )
      return
    return

window.DomainsCommonProcessor = DomainsCommonProcessor