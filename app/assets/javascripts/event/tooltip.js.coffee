class ToolTipsOnConnectingRailwayLineInfo

  constructor: ->

  transfer_infos = (v) ->
    return $( 'li.transfer_info' )

  railway_lines = (v) ->
    return $( 'li.railway_line' )

  process: ->
    _option =
      potision:
        my: "left top"
        at: "left bottom"
      show:
        effect: "slideDown"
        delay: 200
      hide:
        effect: "slideUp"
        delay: 200
      content: ->
        element = $(@)
        if checkAttr( "title" , { is_included_in: element } )
          return "<span class='info_in_tooltip'>#{ element.attr( "title" ) }</span>"
      item: $(@)
      track: true

    $.each [ transfer_infos(@) , railway_lines(@) ] , ->
      @.find( '.info , .remark' ).tooltip( _option )
      return
    return

$( document ).on 'ready page:load' , ->
  t = new ToolTipsOnConnectingRailwayLineInfo()
  t.process()
  return