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

  length_to_even: ->
    return { width: width_new(@) , height: height_new(@) }

  set: ->
    length_info = @.length_to_even()
    @domain.css( 'width' , length_info.width )
    @domain.css( 'height' , length_info.height )
    return

window.LengthToEven = LengthToEven