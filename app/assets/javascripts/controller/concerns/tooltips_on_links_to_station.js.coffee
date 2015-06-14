class TooltipsOnLinksToStation

  constructor: ( @link_domains ) ->

  set: ->
    option =
      potision:
        my: "left top"
        at: "left bottom"
      content: ->
        element = $(@)
        t = new TooltipOnLinkToStation( element )
        return t.to_html()
      items: "[data-station-code-images] , [data-text-ja] , [data-text-hiragana] , [data-text-en]"
      tooltipClass: 'station_name_in_tooltip'
      track: false
    @link_domains.tooltip( option )
    return

window.TooltipsOnLinksToStation = TooltipsOnLinksToStation

class TooltipOnLinkToStation

  constructor: ( @element ) ->

  station_code_images = (v) ->
    return v.element.attr( 'data-station-code-images' )

  text_ja = (v) ->
    return v.element.attr( 'data-text-ja' )

  text_hiragana = (v) ->
    return v.element.attr( 'data-text-hiragana' )

  text_en = (v) ->
    return v.element.attr( 'data-text-en' )

  ary_of_station_code_images = (v) ->
    return station_code_images(v).split( '/' )

  to_html: ->
    str = ""
    str += station_code_images_in_html(@)
    str += text_in_html(@)
    return str

  station_code_images_in_html = (v) ->
    str = ""
    str += "<div class='station_codes'>"
    for image_name in ary_of_station_code_images(v)
      p = new TooltipOnLinkToStationImageName( image_name )
      str += p.to_html()
    str += "</div>"
    return str

  text_in_html = (v) ->
    str = ""
    str += "<div class='text'>"
    str += "<div class='text_ja'>#{ text_ja(v) }</div>"
    str += "<div class='text_ja text_hiragana'>#{ text_hiragana(v) }</div>"
    str += "<div class='text_en'>#{ text_en(v) }</div>"
    str += "</div>"
    return str

class TooltipOnLinkToStationImageName

  constructor: ( @image_name ) ->

  src_basename = (v) ->
    return v.image_name.toLowerCase()
  
  src = (v) ->
    return "/assets/provided_by_tokyo_metro/station_number/#{ src_basename(v) }.png"

  to_html: ->
    return "<img class='station_code' alt='#{ @image_name }' src=#{ src(@) }>"
