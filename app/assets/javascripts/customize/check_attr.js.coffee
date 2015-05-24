checkAttr = ( attr_name , obj ) ->
  v = obj.is_included_in
  attr = v.attr( attr_name )
  return ( typeof( attr ) isnt 'undefined' and attr isnt false )

window.checkAttr = checkAttr