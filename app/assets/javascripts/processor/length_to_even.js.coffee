class LengthToEven

  constructor: ( @domain , @text = false ) ->
    return

  width_new = (v) ->
    w = Math.ceil( v.domain.width() * 1.0 / 2 ) * 2
    if v.text
      w += 2
    return w

  height_new = (v) ->
    return Math.ceil( v.domain.height() * 1.0 / 2 ) * 2

  length_to_even: ( v = null ) ->
    if v isnt null
      # console.log v
      if v.min_width?
        w = Math.max( v.min_width , width_new(@) )
      else if v.max_width?
        w = Math.min( v.max_width , width_new(@) )
      if v.min_height?
        h = Math.max( v.min_height , height_new(@) )
      else if v.max_height?
        w = Math.min( v.max_height , height_new(@) )
    return { width: w , height: h }

  set: ( v = null ) ->
    length_info = @.length_to_even(v)
    @domain.css( 'width' , length_info.width )
    @domain.css( 'height' , length_info.height )
    return

window.LengthToEven = LengthToEven