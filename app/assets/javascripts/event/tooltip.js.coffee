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
      content: ->
        element = $(@)
        if checkAttr( "title" , { is_included_in: element } )
          return "<span class='info_in_tooltip'>#{ element.attr( "title" ) }</span>"
      items: "[title]"
      track: false

    $.each [ transfer_infos(@) , railway_lines(@) ] , ->
      @.find( '.info , .remark' ).tooltip( _option )
      return
    return


$( document ).on 'ready page:load' , ->
  c = new ToolTipsOnConnectingRailwayLineInfo()
  c.process()
  return