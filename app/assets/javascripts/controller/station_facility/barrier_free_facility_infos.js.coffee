# バリアフリー情報の処理

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

window.StationFacilityBarrierFreeFacilityInfos = StationFacilityBarrierFreeFacilityInfos

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