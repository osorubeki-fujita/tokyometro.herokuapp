class StationFacility

  constructor: ->
    @tab_contents = $( '#platform_info_tab_contents' )
    @tokyo_metro_railway_lines = $( '.tokyo_metro_railway_lines' ).first().children( '.railway_lines' ).first()
    @tokyo_metro_railway_lines_in_this_station = @tokyo_metro_railway_lines.children( '.railway_lines_in_this_station' ).first()
    @tokyo_metro_railway_lines_in_another_stations = @tokyo_metro_railway_lines.children( '.railway_lines_in_another_station' ).first()
    @railway_lines_operated_by_other_operators = $( '.other_railway_lines' ).first().children( '.railway_lines' ).first()

  # 各路線のプラットホーム情報の table
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
      table = new StationFacilityPlatformInfoTable( $( this ) )
      table.process()
      return
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

  text_domain = (v) ->
    return v.domain.children( '.text' ).first()

  transfer_additional_info = (v) ->
    return text_domain(v).children( '.additional_info' ).first()

  process_railway_line_code = (v) ->
    _railway_line_code_main = railway_line_code_main(v)
    railway_line_code(v).css( 'height' , _railway_line_code_main.outerHeight( true ) )
    railway_line_code(v).css( 'width' , _railway_line_code_main.outerWidth( true ) )
    railway_line_code(v).css( 'float' , 'left' )
    return
  
  process_text = (v) ->
    _text_domain = text_domain(v)
    p = new DomainsCommonProcessor( _text_domain.children() )
    _text_domain.css( 'height' , p.sum_outer_height( true ) )
    _text_domain.css( 'width' , Math.ceil( p.max_outer_width( true ) * 1.1 ) )
    return

  set_height_of_transfer_additional_info = (v) ->
    _transfer_additional_info = transfer_additional_info(v)
    p = new DomainsCommonProcessor( _transfer_additional_info.children() )
    _transfer_additional_info.css( 'height' , p.max_outer_height( true ) )
    return

  set_height_of_outer_domain = (v) ->
    # h = Math.max( railway_line_code(v).outerHeight( true ) , text_domain(v).outerHeight( true ) )
    # v.domain.css( 'height' , h )
    doms = v.domain.children()
    p1 = new DomainsCommonProcessor( doms )
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( doms , h , 'middle' )
    p2.process()
    v.domain.css( 'height' , h )
    return
    
  set_width_of_outer_domain = (v) ->
    doms = v.domain.children()
    p1 = new DomainsCommonProcessor( doms )
    w = p1.sum_outer_width( true ) + ( v.domain.innerWidth() - v.domain.width() )
    v.domain.css( 'width' , w )

  process: ->
    process_railway_line_code(@)
    process_text(@)
    set_height_of_transfer_additional_info(@)
    set_height_of_outer_domain(@)
    set_width_of_outer_domain(@)
    return

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
      platform_info_tab = $( this )
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