class Header

  constructor: ( @domain = $( '#header' ) ) ->

  set_vertical_align = (v) ->
    p = new DomainsVerticalAlignProcessor( v.domain.children() , 'auto' , 'bottom' )
    p.process()
    return

  process: ->
    set_vertical_align(@)
    return

window.Header = Header
