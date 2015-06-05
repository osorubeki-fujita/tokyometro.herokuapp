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
    process_each_side_domain(@)
    process_specific_infos(@)
    process_toilet_icons(@)
    return

  set_title_width = (v) ->
    title_domain(v).css( 'width' , v.width )
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

#-------- [class] StationFacilityInfosOfEachTypeAndLocatedArea

class StationFacilityInfosOfEachTypeAndLocatedArea

  constructor: ( @domain , @width ) ->
    # console.log @width
    return

  title_domain = (v) ->
    return v.domain.children( '.title' ).first()

  facilities = (v) ->
    return v.domain.children( '.facility' )

  margin_left = (v) ->
    return parseInt( v.domain.css( 'margin-left' ) , 10 )

  process: ->
    set_width_of_title_domain(@)
    process_facilities(@)
    return

  set_width_of_title_domain = (v) ->
    title_domain(v).css( 'width' , v.width - margin_left(v) )
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

  #-------- 具体的な情報
  info = (v) ->
    return v.domain.children( '.info' ).first()

  #---- service_details
  service_details = (v) ->
    return info(v).children( '.service_details' ).first()

  #---- toilet_assistants
  toilet_assistants = (v) ->
    return info(v).children( '.toilet_assistants' ).first()

  #-------- 処理
  process: ->
    process_image_and_number(@)
    process_info(@)
    return

  process_image_and_number = (v) ->
    set_vertical_align_bottom_to_image_and_number(v)
    return

  set_vertical_align_bottom_to_image_and_number = (v) ->
    p = new DomainsVerticalAlignProcessor( image_and_number(v).children() , 'auto' , 'bottom' )
    p.process()
    return

  process_info = (v) ->
    process_service_details(v)
    return

  process_service_details = (v) ->
    service_details(v).children().each ->
      service_detail = $(@)
      p = new DomainsVerticalAlignProcessor( service_detail.children() , 'auto' )
      p.process()
      return
    return
