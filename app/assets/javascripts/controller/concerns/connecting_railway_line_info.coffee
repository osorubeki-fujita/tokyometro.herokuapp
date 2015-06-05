class ConnectingRailwayLineInfo

  constructor: ->

  transfer_infos = (v) ->
    return $( 'li.transfer_info' )

  railway_lines = (v) ->
    return $( 'li.railway_line' )
  
  set_tooltip = (v) ->
    _option =
      potision:
        my: "left top"
        at: "left bottom"
      content: ->
        element = $(@)
        if checkAttr( "title" , { is_included_in: element } )
          return "<span class='in_tooltip text_ja'>#{ element.attr( "title" ) }</span>"
      items: "[title]"
      track: false

    $.each [ transfer_infos(v) , railway_lines(v) ] , ->
      @.find( '.info , .remark' ).tooltip( _option )
      return
    return

  process: ->
    set_tooltip(@)
    return

window.ConnectingRailwayLineInfo = ConnectingRailwayLineInfo