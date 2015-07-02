class TabUl
  constructor: ( @ul ) ->

  li_contents: ->
    # console.log( 'TabUl\#li_contents' )
    return @ul.children( 'li' )

  process: ->
    # console.log( 'TabUl\#process' )
    # console.log( li_contents(@).length )
    p = new DomainsCommonProcessor( @.li_contents() )
    @ul.css( 'height' , p.max_outer_height( true ) )
    return

window.TabUl = TabUl