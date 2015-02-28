class RailwayLine
  constructor: ->

  process_women_only_car = (v) ->
    women_only_car = new WomenOnlyCar()
    women_only_car.process()
    return

  process: ->
    process_women_only_car(@)
    return

window.RailwayLine = RailwayLine

#-------- WomenOnlyCar

class WomenOnlyCar
  constructor: ( @domain = $( '#women_only_car' ) ) ->

  sections = (v) ->
    return v.domain.find( '.section' )

  group_of_section_infos = (v) ->
    return sections(v).children( '.section_infos' )

  places = (v) ->
    return v.domain.find( '.place' )

  process_group_of_section_infos = (v) ->
    group_of_section_infos(v).each ->
      s = new WomenOnlyCarSectionInfos( $( this ) )
      s.process()
      return
    return

  process_places = (v) ->
    _places = places(v)
    d = new DomainsCommonProcessor( _places )
    d.set_css_attribute( 'width' , d.max_width() * 1.2 )
    return

  process: ->
    process_group_of_section_infos(@)
    process_places(@)
    return


class WomenOnlyCarSectionInfos
  constructor: ( @domain ) ->

  children = (v) ->
    return v.domain.children()

  available_time = (v) ->
    return children(v).eq(0)

  domain_of_infos = (v) ->
    return children(v).eq(1)

  infos = (v) ->
    return domain_of_infos(v).children( '.info' )

  process_each_info = (v) ->
    domain_of_infos(v).children( '.info' ).each ->
      i = new WomenOnlyCarSectionInfo( $( this ) )
      i.process()
      return
    return

  process_height_of_domain_of_infos = (v) ->
    p = new DomainsCommonProcessor( infos(v) )
    domain_of_infos(v).css( 'height' , p.sum_outer_height( true ) )
    return

  process_height_of_domain = (v) ->
    p = new DomainsCommonProcessor( children(v) )
    v.domain.css( 'height' , p.max_outer_height( true ) )
    return

  taller_children = (v) ->
    if available_time(v).outerHeight( false ) < infos(v).outerHeight( false )
      c = infos(v)
    else
      c = available_time(v)
    return c

  shorter_children = (v) ->
    if available_time(v).outerHeight( false ) < infos(v).outerHeight( false )
      c = available_time(v)
    else
      c = infos(v)
    return c

  set_vartical_align_center = (v) ->
    _taller = taller_children(v)
    _shorter = shorter_children(v)
    margin_of_shorter = ( _taller.outerHeight( false ) - _shorter.outerHeight( false ) ) * 0.5
    _shorter.css( 'margin-top' , margin_of_shorter ).css( 'margin-bottom' , margin_of_shorter )
    return

  process: ->
    process_each_info(@)
    process_height_of_domain_of_infos(@)
    process_height_of_domain(@)
    set_vartical_align_center(@)
    return

class WomenOnlyCarSectionInfo
  constructor: ( @domain ) ->

  cars = (v) ->
    return v.domain.find( '.car' )

  max_outer_height_of_car_domains = (v) ->
    p = new DomainsCommonProcessor( cars(v) )
    return p.max_outer_height( false ) * 1.5

  max_outer_height_of_children = (v) ->
    p2 = new DomainsCommonProcessor( v.domain.children() )
    return p2.sum_all_of_uniform_height_to_max()

  process_cars = (v) ->
    _max_height = max_outer_height_of_car_domains(v)
    cars(v).each ->
      c = new WomenOnlyCarSectionInfoCar( $( this ) , _max_height )
      c.process()
      return
    return

  process_height = (v) ->
    v.domain.css( 'height' , max_outer_height_of_children(v) )
    return

  process: ->
    process_cars(@)
    process_height(@)
    return

class WomenOnlyCarSectionInfoCar

  constructor: ( @car , @max_height ) ->

  current_height = (v) ->
    return v.car.outerHeight( false )

  padding_top_and_bottom = (v) ->
    return ( v.max_height - current_height(v) ) * 0.5

  process: ->
    _padding_top_and_bottom = padding_top_and_bottom(@)
    @car.css( 'padding-top' , _padding_top_and_bottom ).css( 'padding-bottom' , _padding_top_and_bottom )
    return