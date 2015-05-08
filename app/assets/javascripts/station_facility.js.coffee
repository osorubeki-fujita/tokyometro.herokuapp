class StationFacility

  constructor: ->
    @station_facility_title = $( '#station_facility_title' )
    @tab_contents = $( '#platform_info_tab_contents' )
    if in_station_facility_station_page(@)
      @tokyo_metro_railway_lines = $( '.tokyo_metro_railway_lines' ).first().children( '.railway_lines' ).first()
      @tokyo_metro_railway_lines_in_this_station = @tokyo_metro_railway_lines.children( '.railway_lines_in_this_station' ).first()
      @tokyo_metro_railway_lines_in_another_stations = @tokyo_metro_railway_lines.children( '.railway_lines_in_another_station' ).first()
      @railway_lines_operated_by_other_operators = $( '.other_railway_lines' ).first().children( '.railway_lines' ).first()
    return

  in_station_facility_station_page = (v) ->
    return ( v.station_facility_title.length > 0 )

  # 各路線のプラットホーム情報の table
  tables_of_platform_info_tab_contents = (v) ->
    return v.tab_contents.find( 'table.platform_info' )

  process_railway_lines_related_to_this_station = (v) ->
    $.each [ v.tokyo_metro_railway_lines_in_this_station , v.tokyo_metro_railway_lines_in_another_stations , v.railway_lines_operated_by_other_operators ] , ->
      railway_lines_of_each_category = $(@).children()
      p = new DomainsCommonProcessor( railway_lines_of_each_category )
      $(@).css(  'height' , p.max_outer_height( true ) )
      return
    p = new DomainsCommonProcessor( v.tokyo_metro_railway_lines.children() )
    v.tokyo_metro_railway_lines.css( 'height' , p.sum_outer_height( true ) )
    return

  process_point_ul = (v) ->
    p = new StationFacilityPointUl()
    p.process()
    return
  
  process_google_map = (v) ->
    p = new GoogleMapInStationFacility()
    p.process()
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

  process_tables_of_platform_info_tab_contents = (v) ->
    tables_of_platform_info_tab_contents(v).each ->
      table = new StationFacilityPlatformInfoTable( $(@) )
      table.process()
      return
    return

  #-------- バリアフリー情報の処理
  process_barrier_free_facility_infos = (v) ->
    b = new StationFacilityBarrierFreeFacilityInfos()
    b.process()
    return

  process: ->
    if in_station_facility_station_page(@)
      process_railway_lines_related_to_this_station(@)
      process_point_ul(@)
      process_google_map(@)
      process_platform_infos(@)
      process_barrier_free_facility_infos(@)
    return

window.StationFacility = StationFacility

#--------------------------------
# ※ 以下、クラスの定義
#--------------------------------

#-------------------------------- 出入口情報の処理

class StationFacilityPointUl

  constructor: ( @domain = $( 'ul#exits' ) ) ->

  li_domains = (v) ->
    return v.domain.children( 'li' )
  
  codes_in_li_domains = (v) ->
    return li_domains(v).children( '.code' )

  max_height_of_li_children = (v) ->
    p = new DomainsCommonProcessor( li_domains(v).children() )
    return Math.ceil( p.max_outer_height( false ) )

  max_width_of_codes_in_li_domains = (v) ->
    w = 0
    codes_in_li_domains(v).each ->
      p = new StationFacilityPointCode( $(@) )
      w_of_this_code = p.width_of_code()
      w = Math.max( w , w_of_this_code )
      return
    return Math.ceil(w)

  process: ->
    process_height_of_li_domains(@)
    process_width_of_codes_in_li_domains(@)
    process_width_of_li_domains_and_ul(@)
    return

  # それぞれの li の高さの設定
  process_height_of_li_domains = (v) ->
    h = max_height_of_li_children(v)
    console.log 'max_height_of_li_children: ' + h
    li_domains(v).each ->
      $(@).css( 'height' , h )
      p = new StationFacilityPointLi( $(@) , {height: h} )
      p.process_height()
      return
    return

  # それぞれの li の内部の .code の幅の設定
  process_width_of_codes_in_li_domains = (v) ->
    w = max_width_of_codes_in_li_domains(v)
    console.log 'max_width_of_codes_in_li_domains: ' + w
    codes_in_li_domains(v).each ->
      console.log 'process_width_of_codes_in_li_domains'
      p = new StationFacilityPointCode( $(@) , {width: w} )
      p.process_width()
    return

  width_of_each_li_domain = (v) ->
    w = 0
    li_domains(v).each ->
      p = new DomainsCommonProcessor( $(@).children() )
      w_of_this_li = Math.ceil( p.sum_outer_width( true ) )
      w = Math.max( w , w_of_this_li )
      return
    return w + 1

  process_width_of_li_domains_and_ul = (v) ->
    process_width_of_li_domains(v)
    process_width_of_ul(v)
    return

  process_width_of_li_domains = (v) ->
    w = width_of_each_li_domain(v)
    console.log 'width_of_li_domains: ' + w
    li_domains(v).each ->
      $(@).css( 'width' , w )
      return
    return

  process_width_of_ul = (v) ->
    console.log 'process_width_of_ul'
    v.domain.css( 'width' , width_of_ul(v) )
    return
    
  width_of_ul = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    w_base = p.max_outer_width( true )
    if to_scroll(v)
      w = w_base + 18
      console.log 'scroll'
    else
      w = w_base
      console.log 'not scroll'
    return w
  
  to_scroll = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    height_of_ul_whole = p.sum_outer_height( true )
    height_of_ul_domain = parseInt( v.domain.css( 'height' ) , 10 )
    # console.log height_of_ul_whole
    # console.log height_of_ul_domain
    return height_of_ul_domain < height_of_ul_whole

class StationFacilityPointLi

  constructor: ( @domain , @length ) ->

  child_code = (v) ->
    return v.domain.children( '.code' )

  child_code_of_elevator = (v) ->
    return v.domain.children( '.code.elevator' )

  close_info = (v) ->
    return v.domain.children( '.close' )

  has_child_code = (v) ->
    return ( child_code(v).length is 1 )

  has_code_of_elevator = (v) ->
    return ( child_code_of_elevator(v).length is 1 )

  has_close_info = (v) ->
    return ( close_info(v).length is 1 )

  process_height: ->
    if has_child_code(@)
      p = new StationFacilityPointCode( child_code(@).first() , @length )
      p.process_height()

    if has_code_of_elevator(@)
      p = new StationFacilityPointElevatorCode( child_code_of_elevator(@).first() , @length )
      p.process_height()

    if has_close_info(@)
      p = new StationFacilityPointCloseInfo( close_info(@).first() , @length )
      p.process()
    return

class StationFacilityPointCode

  constructor: ( @domain , @length ) ->
  
  width_of_code: ->
    if has_children(@)
      p = new DomainsCommonProcessor( @domain.children() )
      w = p.sum_outer_width( true )
    else
      w = @domain.width()
    return w

  padding_top_or_bottom = (v) ->
    return Math.ceil( ( v.length.height - v.domain.height() ) * 0.5 )
  
  padding_left_or_right = (v) ->
    default_padding = 4
    return Math.ceil( ( v.length.width - v.domain.width() ) * 0.5 ) + default_padding

  has_children = (v) ->
    return v.domain.children().length > 0

  process_height: ->
    p = padding_top_or_bottom(@)
    @domain.css( 'padding-top' , p )
    @domain.css( 'padding-bottom' , p )
    process_height_of_children(@)
    return
  
  process_height_of_children = (v) ->
    if has_children(v)
      h = v.domain.height()
      p = new DomainsVerticalAlignProcessor( v.domain.children() , h )
      p.process()
    return

  process_width: ->
    if has_children(@)
      w_of_code = @.width_of_code()
      console.log 'process_width: ' + w_of_code
      @domain.children().each ->
        console.log '  outer_width(true)' + $(@).outerWidth( true )
        console.log '  outer_width(false)' + $(@).outerWidth( false )
        console.log '  inner_width(false)' + $(@).innerWidth(  )
        console.log '  width(false)' + $(@).width(  )
        console.log ''
        return
      @domain.css( 'width' , w_of_code )
      return
    p = padding_left_or_right(@)
    @domain.css( 'padding-left' , p )
    @domain.css( 'padding-right' , p )
    return

class StationFacilityPointElevatorCode

  constructor: ( @domain , @length ) ->

  process_height: ->
    p = new DomainsVerticalAlignProcessor( @domain.children() ,  @domain.height() )
    p.process()
    return

class StationFacilityPointCloseInfo

  constructor: ( @domain , @length ) ->

  process: ->
    process_height(@)
    process_child_infos(@)
    return

  process_height = (v) ->
    p = new DomainsVerticalAlignProcessor( v.domain ,  v.length.height )
    p.process()
    return

  process_child_infos = (v) ->
    p1 = new DomainsCommonProcessor( v.domain.children() )
    h = p1.max_outer_height( false )
    p2 = new DomainsVerticalAlignProcessor( v.domain.children() , h )
    p2.process()
    return

#-------------------------------- Google Map の処理

class GoogleMapInStationFacility

  constructor: ( @domain = $( 'iframe#map' ) ) ->

  ul_exits = (v) ->
    return $( 'ul#exits' )

  width_of_domain = (v) ->
    p = new DomainsCommonProcessor( $( '#main_content_wide , #main_content_center' ) )
    return p.max_width()

  width_of_ul_exits = (v) ->
    return ul_exits(v).outerWidth( true )
  
  height_of_ul_exits = (v) ->
    return ul_exits(v).height()

  border_width_of_map = (v) ->
    return parseInt( v.domain.css( 'border-width' ) , 10 )

  width_of_google_map = (v) ->
    return width_of_domain(v) - ( width_of_ul_exits(v) + border_width_of_map(v) * 2 )

  height_of_google_map = (v) ->
    return height_of_ul_exits(v)

  process: ->
    @domain.attr( 'width' , width_of_google_map(@) + 'px' )
    @domain.attr( 'height' , height_of_google_map(@) + 'px' )

#-------------------------------- プラットホーム情報の処理

class StationFacilityPlatformInfoTable

  constructor: ( @domain ) ->

  transfer_infos = (v) ->
    return v.domain.find( 'li.transfer_info' )

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
      info = new StationFacilityTransferInfoInPlatformInfo( $(@) )
      info.process()
    return

class StationFacilityTransferInfoInPlatformInfo

  constructor: ( @domain ) ->
  
  div_domain = (v) ->
    return v.domain.children( '.link_to_railway_line_page , .railway_line_with_no_link' )

  railway_line_code = (v) ->
    return div_domain(v).children().first()

  railway_line_code_main = (v) ->
    return railway_line_code(v).children().first()
  
  railway_line_main_domain = (v) ->
    return div_domain(v).children( '.railway_line' ).first()

  text_domain = (v) ->
    return railway_line_main_domain(v).children( '.text' ).first()

  process: ->
    process_railway_line_code(@)
    process_railway_line_main_domain(@)
    # set_height_of_transfer_additional_info(@)
    set_height_of_outer_domain(@)
    set_width_of_outer_domain(@)
    return

  process_railway_line_code = (v) ->
    _railway_line_code_main = railway_line_code_main(v)
    railway_line_code(v).css( 'height' , _railway_line_code_main.outerHeight( true ) )
    railway_line_code(v).css( 'width' , _railway_line_code_main.outerWidth( true ) )
    return

  process_railway_line_main_domain = (v) ->
    _railway_line_main_domain = railway_line_main_domain(v)
    p = new DomainsCommonProcessor( _railway_line_main_domain.children() )
    _railway_line_main_domain.css( 'height' , p.sum_outer_height( true ) )
    _railway_line_main_domain.css( 'width' , Math.ceil( p.max_outer_width( true ) ) )
    return

  set_height_of_transfer_additional_info = (v) ->
    _transfer_additional_info = transfer_additional_info(v)
    p = new DomainsCommonProcessor( _transfer_additional_info.children() )
    _transfer_additional_info.css( 'height' , p.max_outer_height( true ) )
    return

  set_height_of_outer_domain = (v) ->
    doms = div_domain(v).children()
    p1 = new DomainsCommonProcessor( doms )
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( doms , h , 'top' )
    p2.process()
    v.domain.css( 'height' , h )
    return
    
  set_width_of_outer_domain = (v) ->
    doms = div_domain(v).children()
    p1 = new DomainsCommonProcessor( doms )
    w = Math.max( 100 , p1.sum_outer_width( true ) + ( v.domain.innerWidth() - v.domain.width() ) )
    v.domain.css( 'width' , w )

#-------- [class] StationFacilityPlatformInfoTabUl

class StationFacilityPlatformInfoTabUl extends TabUl
  constructor: ( @ul = $( 'ul#platform_info_tabs' ) ) ->

  # li_contents: ->
    # console.log 'StationFacilityPlatformInfoTabUl\#li_contents'
    # super()
    # return

  process_railway_line_name = (v) ->
    # console.log( 'StationFacilityPlatformInfoTabUl\#process_railway_line_name' )
    # console.log(v)
    # console.log( v.li_contents() )
    v.li_contents().each ->
      platform_info_tab = $(@)
      railway_line_name = platform_info_tab.children( '.railway_line_name' ).first()
      children_of_railway_line_name = railway_line_name.children()
      p = new DomainsCommonProcessor( children_of_railway_line_name )
      railway_line_name.css( 'width' , Math.ceil( p.sum_outer_width( true ) * 1.2 ) )
      railway_line_name.css( 'height' , p.max_outer_height( true ) )
      return
    return

  process: ->
    if @ul.length > 0
      process_railway_line_name(@)
      super()
      return
    return

#--------------------------------
# バリアフリー情報の処理
#--------------------------------

#-------- [class] StationFacilityBarrierFreeFacilityInfos

class StationFacilityBarrierFreeFacilityInfos
  constructor: ( @domain = $( 'ul#station_facility_info' ) ) ->

  contents_grouped_by_type = (v) ->
    return v.domain.children( 'li' )

  contents_grouped_by_located_area = (v) ->
    return contents_grouped_by_type(v).find( '.inside , .outside' )

  process: ->
    process_each_types(@)
    return

  process_each_types = (v) ->
    w = v.domain.width()
    contents_grouped_by_type(v).each ->
      t = new StationFacilityInfosOfEachType( $(@) , v.domain.width() )
      t.process()
      return
    return

#-------- [class] StationFacilityInfosOfEachType

class StationFacilityInfosOfEachType

  constructor: ( @domain , @width ) ->

  domain_height = (v) ->
    return title_domain(v).outerHeight( true ) + inside(v).outerHeight( true ) + outside(v).outerHeight( true )

  title_domain = (v) ->
    return v.domain.children( '.title' ).first()

  inside = (v) ->
    return v.domain.children( 'ul.inside' ).first()

  outside = (v) ->
    return v.domain.children( 'ul.outside' ).first()
  
  inside_and_outside = (v) ->
    return v.domain.children( 'ul.inside , ul.outside' )

  operation_day_domains = (v) ->
    return v.domain.find( 'li.operation_day' )
  
  escalator_direction_domains = (v) ->
    return v.domain.find( 'li.escalator_direction' )

  service_time_domains = (v) ->
    return v.domain.find( 'li.service_time' )

  remark_domains = (v) ->
    return v.domain.find( '.remark' )

  icons = (v) ->
    return v.domain.find( 'img.barrier_free_facility' )
  
  is_toilet = (v) ->
    return v.domain.hasClass( 'toilet' )

  process: ->
    set_title_width(@)
    set_title_height(@)
    process_each_side_domain(@)
    process_specific_infos(@)
    process_toilet_icons(@)
    set_domain_height(@)
    return

  set_title_width = (v) ->
    title_domain(v).css( 'width' , v.width )
    return

  set_title_height = (v) ->
    t = new StationFacilityBarrierFreeFacilityTitle( title_domain(v) )
    t.process()
    return

  process_each_side_domain = (v) ->
    $.each [ inside(v) , outside(v) ] , ->
      instance_of_each_area = new StationFacilityInfosOfEachTypeAndLocatedArea( $(@) , v.width )
      # console.log $(@)
      instance_of_each_area.process()
      return
    return

  process_specific_infos = (v) ->
    $.each [ operation_day_domains(v) , escalator_direction_domains(v)  , service_time_domains(v) , remark_domains(v) ] , ->
      if $(@).length > 0
        length_processor = new DomainsCommonProcessor( $(@) )
        length_processor.set_all_of_uniform_width_to_max()
      return
    return

  process_toilet_icons = (v) ->
    if is_toilet(v)
      _icons = icons(v)
      max_width = 0
      number_of_icons = _icons.length
      loaded_icons = 0
      # console.log _icons
      # console.log 'number_of_icons: ' + number_of_icons
      for i in [ 0...( number_of_icons ) ]
        icon = _icons.eq(i)
        icon.on 'load.toilet_icon' , ->
          loaded_icons += 1
          # console.log $(@)
          # console.log 'width (each): ' + $(@).width()
          max_width = Math.max( max_width , $(@).width() )
          # console.log 'loaded_icons: ' + loaded_icons
          if loaded_icons is number_of_icons
            p = new DomainsHorizontalAlignProcessor( _icons , max_width , 'left' )
            p.process()
          return
    return

  set_domain_height = (v) ->
    v.domain.css( 'height' , domain_height(v) )
    return

#-------- [class] StationFacilityInfosOfEachTypeAndLocatedArea

class StationFacilityInfosOfEachTypeAndLocatedArea

  constructor: ( @domain , @width ) ->
    # console.log @width
    return

  domain_height = (v) ->
    p = new DomainsCommonProcessor( facilities(v) )
    return title_domain(v).outerHeight( true ) + p.sum_outer_height( true )

  title_domain = (v) ->
    return v.domain.children( '.title' ).first()

  facilities = (v) ->
    return v.domain.children( '.facility' )
  
  margin_left = (v) ->
    return parseInt( v.domain.css( 'margin-left' ) , 10 )

  process: ->
    set_width_of_title_domain(@)
    set_height_of_title_domain(@)
    process_facilities(@)
    @domain.css( 'height' , domain_height(@) )
    return
  
  set_width_of_title_domain = (v) ->
    title_domain(v).css( 'width' , v.width - margin_left(v) )
    return
  
  set_height_of_title_domain = (v) ->
    t = new StationFacilityBarrierFreeFacilityTitle( title_domain(v) )
    t.process()
    return

  process_facilities = (v) ->
    facilities(v).each ->
      f = new StationFacilityInfosOfEachSpecificFacility( $(@) )
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
      service_detail = $(@)
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

  title_text_en = (v) ->
    return v.domain.children( '.text_en' ).first()
  
  set_title_height_new = (v) ->
    v.title_height_new = Math.max( v.domain.height() , title_text_en(v).height() )
    return

  process: ->
    set_title_height_new(@)
    _title_height_new = @title_height_new
    $( [ @domain , title_text_en(@) ] ).each ->
      $(@).css( 'height' , _title_height_new )
      $(@).css( 'margin-top' , _title_height_new - $(@).height() )
      return
    return