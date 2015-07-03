class LengthToEven

  constructor: ( @domain , @text = false ) ->
    return

  width_new = (v) ->
    w = Math.ceil( v.domain.width() * 1.0 / 2 ) * 2
    if v.text
      w += 4
    return w

  height_new = (v) ->
    return Math.ceil( v.domain.height() * 1.0 / 2 ) * 2

  length_info = ( v , info_of_max_or_min = null ) ->
    w = width_new(v)
    h = height_new(v)
    if info_of_max_or_min isnt null
      # console.log info_of_max_or_min
      if v.min_width?
        w = Math.max( info_of_max_or_min.min_width , w )
      else if v.max_width?
        w = Math.min( info_of_max_or_min.max_width , w )
      if v.min_height?
        h = Math.max( info_of_max_or_min.min_height , h )
      else if v.max_height?
        w = Math.min( info_of_max_or_min.max_height , h )
    return { width: w , height: h }

  set: ( info_of_max_or_min = null ) ->
    l_info = length_info( @ , info_of_max_or_min )
    @domain.css( 'width' , l_info.width )
    @domain.css( 'height' , l_info.height )
    return

window.LengthToEven = LengthToEven
