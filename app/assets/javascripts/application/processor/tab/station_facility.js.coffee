#-------- [class] StationFacilityPlatformInfoTabTarget

class StationFacilityPlatformInfoTabTarget
  constructor: ( @anchor , @tab_id ) ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#constructor'
    # console.log( 'anchor: ' + @anchor + ' / ' + 'tab_id: ' + @tab_id )

  is_included_in: ( contents ) ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#is_included_in'
    # console.log( 'search_by: ' + '#' + @tab_id )
    return contents.is( '\#' + @tab_id )

  is_not_included_in: ( contents ) ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#is_not_included_in'
    return !( is_included_in( contents ) )

  set_anchor: ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#set_anchor'
    window.location.hash = @anchor
    return

#-------- [class] StationFacilityPlatformInfoTabProcessor

class StationFacilityPlatformInfoTabProcessor

  constructor: ( @tab , @content , @target ) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#constructor'

  content_matches = (v) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#content_matches'
    return ( v.content.attr( 'id' ) is v.target.tab_id )

  hide = (v) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#hide'
    $.each [ v.tab , v.content ] , ->
      $( this ).removeClass( 'displayed' )
      $( this ).addClass( 'hidden' )
      return
    return

  display = (v) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#display'
    $.each [ v.tab , v.content ] , ->
      $( this ).removeClass( 'hidden' )
      $( this ).addClass( 'displayed' )
      return
    return

  process: ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#process'
    # console.log( 'attr id: ' + @content.attr( 'id' ) + ' / ' + 'target tab id: ' + @target.tab_id + ' / ' + 'match: ' + content_matches(@) )
    unless content_matches(@)
      hide(@)
    else
      display(@)
    return

#-------- [class] StationFacilityTabsAndContents

class StationFacilityTabsAndContents

  constructor: ( @platform_info_tabs = $( 'ul#platform_info_tabs' ).children( 'li' ) , @platform_info_tab_contents = $( '#platform_info_tab_contents' ).find( 'li.platform_info_tab_content' ) ) ->
    # console.log 'construct StationFacilityTabsAndContents\#constructor'
    return

  # ページを最初に表示した際の初期化
  initialize_platform_infos: ->
    # console.log 'StationFacilityTabsAndContents\#initialize_platform_infos'
    # console.log contents_exists(@)
    if contents_exists(@)
      _anchor = anchor(@)
      target = new StationFacilityPlatformInfoTabTarget( _anchor , tab_id_of_platform_info( @ , _anchor ) )

      #-------- アンカーが指定されている場合
      if anchor_is_defined( @ , target )
        #---- アンカーが正しく指定されている場合
        if anchor_is_valid_as_platform_info( @ , target )
          console.log( "指定OK: " + _anchor )
          #-- アンカーに適合するタブを表示
          display_platform_info_tab_of( @ , target , false )
        #---- アンカーが正しく指定されていない場合
        else
          console.log( "指定NG: " + _anchor )
          #-- 最初のタブを表示
          display_first_platform_info_tab( @ , true )

      #-------- アンカーが指定されていない場合
      else
        console.log( "未指定: " + _anchor )
        #-- 最初のタブを表示
        display_first_platform_info_tab( @ , false )
        return
      return

    return

  #-------- 監視中に変更があった場合の処理
  hook_while_observing_platform_infos: ->
    # console.log 'StationFacilityTabsAndContents\#hook_while_observing_platform_infos'
    if anchor_is_defined(@)
      _anchor = anchor(@)
      target = new StationFacilityPlatformInfoTabTarget( _anchor , tab_id_of_platform_info( @ , _anchor ) )
      if anchor_is_valid_as_platform_info( @ , target )
        process_platform_info_tabs( @ , target )
      return
    else
      display_first_platform_info_tab( @ , false )
    return

  #-------- id で指定されたタブの内容を表示
  display_platform_info_tab_of_id: ( tab_id , change_location = false ) ->
    # console.log 'StationFacilityTabsAndContents\#display_platform_info_tab_of_id'
    # console.log tab_id
    _anchor = anchor_name_of_platform_info( @ , tab_id )
    target = new StationFacilityPlatformInfoTabTarget( _anchor , tab_id )
    display_platform_info_tab_of( @ , target , change_location )
    return

  contents_exists = (v) ->
    # console.log 'StationFacilityTabsAndContents\#contents_exists'
    return v.platform_info_tab_contents.length > 0

  anchor = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor'
    return window.location.hash.replace( "\#" , "" )

  anchor_is_not_defined = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_not_defined'
    return anchor(v) is ''

  anchor_is_defined = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_defined'
    return !( anchor_is_not_defined(v) )

  anchor_is_valid_as_platform_info = ( v , target ) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_valid_as_platform_info'
    return target.is_included_in( v.platform_info_tab_contents )

  #-------- タブ（複数）の処理
  process_platform_info_tabs = ( v , target ) ->
    # console.log 'StationFacilityTabsAndContents\#process_platform_info_tabs'
    # console.log v
    v.platform_info_tab_contents.each ->
      content = $( this )
      tab = v.platform_info_tabs.filter( '.tab_for_' + content.attr( 'id' ) )
      processor = new StationFacilityPlatformInfoTabProcessor( tab , content , target )
      processor.process()
      return
    return

  #-------- 最初のタブの id
  first_platform_info_tab_id = (v) ->
    # console.log 'StationFacilityTabsAndContents\#first_platform_info_tab_id'
    return v.platform_info_tab_contents.first().attr( 'id' )

  #-------- 指定されたタブの内容を表示
  display_platform_info_tab_of = ( v , target , change_location = false ) ->
    # console.log 'StationFacilityTabsAndContents\#display_platform_info_tab_of'
    process_platform_info_tabs( v , target )
    if change_location
      target.set_anchor()
    return

  #-------- 最初のタブの内容を表示
  display_first_platform_info_tab = ( v , change_location = false ) ->
    # console.log 'StationFacilityTabsAndContents\#display_first_platform_info_tab'
    _first_tab_id = first_platform_info_tab_id(v)
    console.log '_first_tab_id: ' + _first_tab_id
    _anchor_name = anchor_name_of_platform_info( v , _first_tab_id )
    console.log '_anchor_name: ' + _anchor_name
    unless _anchor_name == null
      target =new StationFacilityPlatformInfoTabTarget( _anchor_name , _first_tab_id )
      display_platform_info_tab_of( v , target , change_location )
      return
    return

  anchor_name_of_platform_info = ( v , tab_id ) ->
    unless tab_id == null
      anchor_name = tab_id.replace( /\#?platform_info_/ , "" )
    else
      anchor_name = null
    return anchor_name

  tab_id_of_platform_info = ( v , anchor ) ->
    return 'platform_info_' + anchor

window.StationFacilityTabsAndContents = StationFacilityTabsAndContents