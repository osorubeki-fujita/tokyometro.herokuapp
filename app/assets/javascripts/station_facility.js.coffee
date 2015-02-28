class StationFacility
  constructor: ->
    @tab_contents = $( '#platform_info_tab_contents' )
    @tokyo_metro_railway_lines = $( '.tokyo_metro_railway_lines' ).first().children( '.railway_lines' ).first()
    @tokyo_metro_railway_lines_in_this_station = @tokyo_metro_railway_lines.children( '.railway_lines_in_this_station' ).first()
    @tokyo_metro_railway_lines_in_another_stations = @tokyo_metro_railway_lines.children( '.railway_lines_in_another_station' ).first()
    @railway_lines_operated_by_other_operators = $( '.other_railway_lines' ).first().children( '.railway_lines' ).first()

  tables_of_platform_info_tab_contents = (v) ->
    return v.tab_contents.find( 'table.platform_info' )

  process_railway_lines_related_to_this_station = (v) ->
    $.each [ v.tokyo_metro_railway_lines_in_this_station , v.tokyo_metro_railway_lines_in_another_stations , v.railway_lines_operated_by_other_operators ] , ->
      railway_lines_of_each_category = $( this ).children()
      p = new DomainsCommonProcessor( railway_lines_of_each_category )
      $( this ).css(  'height' , p.max_outer_height( true ) )
      return
    p = new DomainsCommonProcessor( v.tokyo_metro_railway_lines.children() )
    v.tokyo_metro_railway_lines.css( 'height' , p.sum_outer_height( true ) )
    return

  process_tables_of_platform_info_tab_contents = (v) ->
    tables_of_platform_info_tab_contents(v).each ->
      table = new StationFacilityPlatformInfoTable( $( this ) )
      table.process()
      return
    return

  #-------- プラットホーム情報のタブとその内容の処理・初期化
  process_platform_infos = (v) ->
    process_tables_of_platform_info_tab_contents(v)

    tab_ul_processor = new StationFacilityPlatformInfoTabUl()
    tab_ul_processor.process()

    platform_info_tabs = tab_ul_processor.li_contents()
    t = new StationFacilityTabsAndContents( platform_info_tabs )
    t.initialize_platform_infos()
    return

  #-------- バリアフリー情報の処理
  process_barrier_free_facility_infos = (v) ->
    b = new StationFacilityBarrierFreeFacilityInfos()
    b.process()
    return

  process: ->
    process_railway_lines_related_to_this_station(@)
    process_platform_infos(@)
    process_barrier_free_facility_infos(@)

window.StationFacility = StationFacility

#--------------------------------
# プラットホーム情報の処理
#--------------------------------

#-------- changeStationFacilityPlatformInfoTabByPageLink
#-------- ページ内のタブをクリックすることによる処理

changeStationFacilityPlatformInfoTabByPageLink = ( tab_id , change_location = true ) ->
  s = new StationFacilityTabsAndContents()
  s.display_platform_info_tab_of_id( tab_id , change_location )
  return

window.changeStationFacilityPlatformInfoTabByPageLink = changeStationFacilityPlatformInfoTabByPageLink

#--------------------------------
# ※ 以下、クラスの定義
#--------------------------------

#-------------------------------- プラットホーム情報の処理

class StationFacilityPlatformInfoTable
  constructor: ( @domain ) ->

  transfer_infos = (v) ->
    return v.domain.find( '.transfer_info' )

  # 乗換情報の処理
  process_transfer_infos = (v) ->
    platform_infos = new StationFacilityTransferInfosInPlatformInfos( transfer_infos(v) )
    platform_infos.process()
    return

  process: ->
    process_transfer_infos(@)
    return

class StationFacilityTransferInfosInPlatformInfos
  constructor: ( @domains ) ->
  process: ->
    @domains.each ->
      info = new StationFacilityTransferInfoInPlatformInfo( $( this ) )
      info.process()
    return

class StationFacilityTransferInfoInPlatformInfo
  constructor: ( @domain ) ->

  railway_line_code = (v) ->
    return v.domain.children().first()

  railway_line_code_main = (v) ->
    return railway_line_code(v).children().first()

  string_domain = (v) ->
    return v.domain.children( '.string' ).first()

  transfer_additional_info = (v) ->
    return string_domain(v).children( '.additional_info' ).first()

  process_railway_line_code = (v) ->
    _railway_line_code_main = railway_line_code_main(v)
    railway_line_code(v).css( 'height' , _railway_line_code_main.outerHeight( true ) ).css( 'width' , _railway_line_code_main.outerWidth( true ) ).css( 'float' , 'left' )
    return

  set_height_of_transfer_additional_info = (v) ->
    _transfer_additional_info = transfer_additional_info(v)
    p = new DomainsCommonProcessor( _transfer_additional_info.children() )
    _transfer_additional_info.css( 'height' , p.max_outer_height( true ) )
    return

  set_height_of_outer_domain = (v) ->
    h = Math.max( railway_line_code(v).outerHeight( true ) , string_domain(v).outerHeight( true ) )
    v.domain.css( 'height' , h )

  process: ->
    process_railway_line_code(@)
    set_height_of_transfer_additional_info(@)
    set_height_of_outer_domain(@)
    return

#-------- [class] StationFacilityPlatformInfoTabUl

class StationFacilityPlatformInfoTabUl extends TabUl
  constructor: ( @ul = $( 'ul#platform_info_tabs' ) ) ->

  # li_contents: ->
    # console.log 'StationFacilityPlatformInfoTabUl\#li_contents'
    # super()
    # return

  process_railway_line_name = (v) ->
    console.log 'StationFacilityPlatformInfoTabUl\#process_railway_line_name'
    console.log v
    console.log v.li_contents()
    v.li_contents().each ->
      platform_info_tab = $( this )
      railway_line_name = platform_info_tab.children( '.railway_line_name' ).first()
      children_of_railway_line_name = railway_line_name.children()
      p = new DomainsCommonProcessor( children_of_railway_line_name )
      railway_line_name.css( 'width' , p.sum_outer_width( true ) * 1.2 )
      railway_line_name.css( 'height' , p.max_outer_height( true ) )
      return
    return

  process: ->
    if @ul.length > 0
      process_railway_line_name(@)
      super()
      return
    return

#-------- [class] StationFacilityPlatformInfoTabTarget

class StationFacilityPlatformInfoTabTarget
  constructor: ( @anchor , @tab_id ) ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#constructor'
    # console.log( 'anchor: ' + @anchor + ' / ' + 'tab_id: ' + @tab_id )
  is_included_in: ( contents ) ->
    # console.log 'StationFacilityPlatformInfoTabTarget\#is_included_in'
    # console.log( 'search_by: ' + '#' + @tab_id )
    return contents.is( '#' + @tab_id )
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

  content_matches = ( value ) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#content_matches'
    return ( value.content.attr( 'id' ) is value.target.tab_id )

  hide = ( value ) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#hide'
    $.each [ value.tab , value.content ] , ->
      $( this ).removeClass( 'displayed' )
      $( this ).addClass( 'hidden' )
      return
    return

  display = ( value ) ->
    # console.log 'StationFacilityPlatformInfoTabProcessor\#display'
    $.each [ value.tab , value.content ] , ->
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

  constructor: ( @platform_info_tabs = $( 'ul#platform_info_tabs' ).children( 'li' ) , @platform_info_contents = $( '#platform_info_tab_contents' ).find( 'li.platform_info_tab_content' ) ) ->
    # console.log 'construct StationFacilityTabsAndContents\#constructor'
    return

  # ページを最初に表示した際の初期化
  initialize_platform_infos: ->
    # console.log 'StationFacilityTabsAndContents\#initialize_platform_infos'
    if contents_exists(@)
      _anchor = anchor(@)
      target = new StationFacilityPlatformInfoTabTarget( _anchor , tab_id_of_platform_info( @ , _anchor ) )
      #-------- アンカーが指定されている場合
      if anchor_is_defined( @ , target )
        #---- アンカーが正しく指定されている場合
        if anchor_is_valid_as_platform_info( @ , target )
          # console.log( "指定OK: " + _anchor )
          #-- アンカーに適合するタブを表示
          display_platform_info_tab_of( @ , target , false )
        #---- アンカーが正しく指定されていない場合
        else
          # console.log( "指定NG: " + _anchor )
          #-- 最初のタブを表示
          display_first_platform_info_tab( @ , true )
      #-------- アンカーが指定されていない場合
      else
        # console.log( "未指定: " + _anchor )
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

  contents_exists = ( v ) ->
    # console.log 'StationFacilityTabsAndContents\#contents_exists'
    return v.platform_info_contents.length > 0

  anchor = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor'
    return window.location.hash.replace( "#" , "" )

  anchor_is_not_defined = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_not_defined'
    return anchor(v) is ''

  anchor_is_defined = (v) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_defined'
    return !( anchor_is_not_defined(v) )

  anchor_is_valid_as_platform_info = ( v , target ) ->
    # console.log 'StationFacilityTabsAndContents\#anchor_is_valid_as_platform_info'
    return target.is_included_in( v.platform_info_contents )

  #-------- タブ（複数）の処理
  process_platform_info_tabs = ( v , target ) ->
    # console.log 'StationFacilityTabsAndContents\#process_platform_info_tabs'
    # console.log v
    v.platform_info_contents.each ->
      content = $( this )
      tab = v.platform_info_tabs.filter( '.' + content.attr( 'id' ) )
      processor = new StationFacilityPlatformInfoTabProcessor( tab , content , target )
      processor.process()
      return
    return

  #-------- 最初のタブの id
  first_platform_info_tab_id = (v) ->
    # console.log 'StationFacilityTabsAndContents\#first_platform_info_tab_id'
    return v.platform_info_contents.first().attr( 'id' )

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
    # console.log '_first_tab_id: ' + _first_tab_id
    _anchor = anchor_name_of_platform_info( v , _first_tab_id )
    target =new StationFacilityPlatformInfoTabTarget( _anchor , _first_tab_id )
    display_platform_info_tab_of( v , target , change_location )
    return

  anchor_name_of_platform_info = ( v , tab_id ) ->
    return tab_id.replace( /\#?platform_info_/ , "" )

  tab_id_of_platform_info = ( v , anchor ) ->
    return 'platform_info_' + anchor

#-------- ObserverOfStationFacilityPlatformInfoTab

class ObserverOfStationFacilityPlatformInfoTab
  constructor: ( @anchor = window.location.hash.replace( "#" , "" ) ) ->
  location_hash_was_changed = ( value ) ->
    return window.location.hash.replace( "#" , "" ) isnt value.anchor
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

#--------------------------------
# バリアフリー情報の処理
#--------------------------------

#-------- [class] StationFacilityBarrierFreeFacilityInfos

class StationFacilityBarrierFreeFacilityInfos
  constructor: ( @domain = $( '#station_facility_info' ) ) ->

  contents_grouped_by_type: ->
    return @domain.children()

  process: ->
    process_each_types(@)
    set_title_width(@)
    set_margins_to_each_infos_grouped_by_type_and_located_area(@)
    return

  contents_grouped_by_located_area = (v) ->
    return v.domain.find( '.inside , .outside' )

  process_each_types = (v) ->
    v.contents_grouped_by_type().each ->
      t = new StationFacilityInfosOfEachType( $( this ) )
      t.process()
      return
    return

  set_title_width = (v) ->
    c = contents_grouped_by_located_area(v)

    p1 = new DomainsCommonProcessor(c)
    title_width = p1.max_outer_width( true )

    p2 = new DomainsCommonProcessor( c.find( '.title' ) )
    p2.set_css_attribute( 'width' , title_width )
    return

  set_margins_to_each_infos_grouped_by_type_and_located_area = (v) ->
    c = contents_grouped_by_located_area(v)
    p = new DomainsCommonProcessor(c)
    title_width = p.max_outer_width()
    c.each ->
      margin_left = $( this ).marginLeft
      $( this ).css( 'margin-right' , 0 )
      $( this ).css( 'width' , title_width - margin_left )
      return
    return

#-------- [class] StationFacilityInfosOfEachType

class StationFacilityInfosOfEachType

  constructor: ( @domain ) ->

  process: ->
    set_title_height_of_each_station_facility_type(@)
    process_each_side_domain(@)
    $.each [ operation_day_domains(@) , service_time_domains(@) , remark_domains(@) ] , ->
      length_processor = new DomainsCommonProcessor( $( this ) )
      length_processor.set_all_of_uniform_width_to_max()
      return
    @domain.css( 'height' , domain_height(@) )
    return

  domain_height = (v) ->
    return title_domain(v).outerHeight( true ) + inside(v).outerHeight( true ) + outside(v).outerHeight( true )

  title_domain = (v) ->
    return v.domain.children( '.title' ).first()

  inside = (v) ->
    return v.domain.children( '.inside' ).first()

  outside = (v) ->
    return v.domain.children( '.outside' ).first()

  operation_day_domains = (v) ->
    return v.domain.find( '.operation_day' )

  service_time_domains = (v) ->
    return v.domain.find( '.service_time' )

  remark_domains = (v) ->
    return v.domain.find( '.remark' )

  set_title_height_of_each_station_facility_type = (v) ->
    t = new StationFacilityBarrierFreeFacilityTitle( title_domain(v) )
    t.process()
    return

  process_each_side_domain = (v) ->
    $.each [ inside(v) , outside(v) ] , ->
      instance_of_each_area = new StationFacilityInfosOfEachTypeAndLocatedArea( $( this ) )
      # console.log $( this )
      instance_of_each_area.process()
      return
    return

#-------- [class] StationFacilityInfosOfEachTypeAndLocatedArea

class StationFacilityInfosOfEachTypeAndLocatedArea
  constructor: ( @domain ) ->

  process: ->
    process_title_domain(@)
    process_facilities(@)
    @domain.css( 'height' , domain_height(@) )
    return

  domain_height = (v) ->
    p = new DomainsCommonProcessor( facilities(v) )
    return title_domain(v).outerHeight( true ) + p.sum_outer_height( true )

  title_domain = (v) ->
    return v.domain.children( '.title' ).first()

  facilities = (v) ->
    return v.domain.children( '.facility' )

  process_title_domain = (v) ->
    t = new StationFacilityBarrierFreeFacilityTitle( title_domain(v) )
    t.process()
    return

  process_facilities = (v) ->
    facilities(v).each ->
      f = new StationFacilityInfosOfEachSpecificFacility( $( this ) )
      f.process()
      return
    return


#-------- [class] StationFacilityInfosOfEachSpecificFacility

class StationFacilityInfosOfEachSpecificFacility
  constructor: ( @domain ) ->

  #---- 画像と番号
  image_and_number = (v) ->
    return v.domain.children( '.image_and_number' ).first()

  number = (v) ->
    return image_and_number(v).children().eq(1)

  margin_top_of_number = (v) ->
    return image_and_number(v).innerHeight() - number(v).outerHeight( true )

  process_image_and_number = (v) ->
    _image_and_number = image_and_number(v)
    p = new DomainsCommonProcessor( _image_and_number.children() )
    _image_and_number.css( 'height' , p.max_outer_height( true ) )
    set_margin_top_to_number(v)
    return

  set_margin_top_to_number = (v) ->
    number(v).css( 'margin-top', margin_top_of_number(v) )
    return

  #-------- 具体的な情報
  info = (v) ->
    return v.domain.children( '.info' ).first()

  facility_height = (v) ->
    return Math.max( number(v).outerHeight( true ) , info(v).height() ) 

  process_info = (v) ->
    process_service_details(v)
    process_toilet_assistants(v)

    _info = info(v)
    p = new DomainsCommonProcessor( _info.children() )
    _info.css( 'height' , p.sum_outer_height( true ) )

    v.domain.css( 'height' , facility_height(v) )
    return

  #---- service_details
  service_details = (v) ->
    return info(v).children( '.service_details' ).first()

  process_service_details = (v) ->
    service_details(v).children().each ->
      service_detail = $( this )
      escalator_directions = service_detail.children( '.escalator_directions' ).first()
      p1 = new DomainsCommonProcessor( escalator_directions.children() )
      escalator_directions.css( 'height' , p1.max_outer_height( true ) )
      p2 = new DomainsCommonProcessor( service_detail.children() )
      service_detail.css( 'height' , p2.max_outer_height( true ) )
      return
    return

  #---- toilet_assistants
  toilet_assistants = (v) ->
    return info(v).children( '.toilet_assistants' ).first()

  process_toilet_assistants = (v) ->
    _toilet_assistants = toilet_assistants(v)
    p = new DomainsCommonProcessor( _toilet_assistants.children() )
    _toilet_assistants.css( 'height' , p.max_outer_height( true ) )
    return

  #-------- 処理
  process: ->
    process_image_and_number(@)
    process_info(@)
    return

class StationFacilityBarrierFreeFacilityTitle
  constructor: ( @domain ) ->
    # console.log 'StationFacilityBarrierFreeFacilityTitle\#constructor'

  title_text_ja = (v) ->
    return v.domain.children().eq(0)

  title_text_en = (v) ->
    return v.domain.children().eq(1)

  title_height = (v) ->
    return Math.max( title_text_ja(v).height() , title_text_en(v).height() )

  title_text_margin_top = ( v , domain ) ->
    return title_height(v) - domain.height()

  title_text_ja_margin_top = (v) ->
    return title_text_margin_top( v , title_text_ja(v) )

  title_text_en_margin_top = (v) ->
    return title_text_margin_top( v , title_text_en(v) )

  process: ->
    title_text_ja(@).css( 'margin-top' , title_text_ja_margin_top(@) )
    title_text_en(@).css( 'margin-top' , title_text_en_margin_top(@) )
    @domain.css( 'height' , title_height(@) )
    return