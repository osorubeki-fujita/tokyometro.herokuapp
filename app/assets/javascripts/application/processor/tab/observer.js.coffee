#-------- ObserverOfStationFacilityPlatformInfoTab

class ObserverOfStationFacilityPlatformInfoTab

  constructor: ( @anchor = window.location.hash.replace( "\#" , "" ) ) ->

  location_hash_was_changed = ( value ) ->
    return( window.location.hash.replace( "\#" , "" ) isnt value.anchor )

  hook = ( value ) ->
    # console.log 'ObserverOfStationFacilityPlatformInfoTab#hook'
    s = new StationFacilityTabsAndContents()
    s.hook_while_observing_platform_infos()
    return

  listen: ->
    # console.log 'ObserverOfStationFacilityPlatformInfoTab#listen'
    if location_hash_was_changed( @ )
      # console.log @anchor
      @anchor = window.location.hash.replace( "\#" , "" )
      hook(@)
    return

  duration: ->
    return 1500

window.ObserverOfStationFacilityPlatformInfoTab = ObserverOfStationFacilityPlatformInfoTab