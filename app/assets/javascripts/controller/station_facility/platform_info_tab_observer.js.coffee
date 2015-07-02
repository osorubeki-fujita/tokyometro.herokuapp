#-------- StationFacilityPlatformInfoTabObserver

class StationFacilityPlatformInfoTabObserver

  constructor: ->
    # console.log "StationFacilityPlatformInfoTabObserver\#constructor"
    @anchor = anchor_without_char(@)
    # console.log @anchor

    # s = new StationFacility()
    # s.change_platform_info_tabs()
    return

  duration: ->
    return 1500

  anchor_without_char = (v) ->
    return window.location.hash.replace( "\#" , "" ) 

  location_hash_was_changed = (v) ->
    return( anchor_without_char(v) isnt v.anchor )

  listen: ->
    # console.log 'StationFacilityPlatformInfoTabObserver#listen'
    if location_hash_was_changed(@)
      @anchor = anchor_without_char(@)
      # console.log 'location_hash_was_changed: to ' + @anchor
      hook(@)
    return

  hook = ( value ) ->
    # console.log 'StationFacilityPlatformInfoTabObserver#hook'
    s = new StationFacilityPlatformInfoTabsAndContents()
    s.hook_while_observing_platform_infos()
    return

window.StationFacilityPlatformInfoTabObserver = StationFacilityPlatformInfoTabObserver