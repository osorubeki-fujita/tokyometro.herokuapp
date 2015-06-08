class RailwayLine

  constructor: ->

  #---- 領域

  railway_line_title = (v) ->
    return $( '#railway_line_title' )

  travel_time = (v) ->
    return $( '#travel_time' )

  travel_time_info = (v) ->
    return travel_time(v)
      .find( 'table.travel_time_info' )

  content_headers = (v) ->
    return $( '#links_to_railway_line_info_pages , #travel_time , #women_only_car' )
      .children( '.content_header' )

  #---- 判定

  in_railway_line_title = (v) ->
    return railway_line_title(v).length > 0

  has_multiple_travel_time_info_tables = (v) ->
    return travel_time_info(v).length > 1
  
  #---- 数値

  max_width_of_travel_time_info_tables = (v) ->
    n = 0
    travel_time_info(v).each ->
      table = new TravelTimeInfoTable( $( this ) )
      n = Math.max( n , table.inner_width() )
      return
    return n

  process: ->
    if in_railway_line_title(@)
      process_content_headers(@)
      process_travel_time_info_tables(@)
      process_women_only_car(@)
    return

  process_content_headers = (v) ->
    p = new ContentHeaderProcessor( content_headers(v) )
    p.process()
    return

  process_travel_time_info_tables = (v) ->
    # console.log( 'RailwayLine\#process_travel_time_info_tables' )
    if has_multiple_travel_time_info_tables(v)
      # console.log( 'RailwayLine\#has_multiple_travel_time_info_tables' )
      _width_new = max_width_of_travel_time_info_tables(v)
      # console.log( 'width_new: ' + _width_new )
      travel_time_info(v).each ->
        table = new TravelTimeInfoTable( $( this ) )
        table.set_width( _width_new )
        return

    travel_time_info(v).each ->
      table = new TravelTimeInfoTable( $( this ) )
      table.set_width_of_station_info_domain()
      return
    return

  process_women_only_car = (v) ->
    women_only_car = new WomenOnlyCar()
    women_only_car.process()
    return

window.RailwayLine = RailwayLine

#-------- TravelTimeInfoTable

class TravelTimeInfoTable

  constructor: ( @domain ) ->

  inner_width: ->
    # console.log( 'TravelTimeInfoTable\#inner_width' )
    return @domain.innerWidth()

  set_width: ( _width ) ->
    @domain.css( 'width' , _width )
    return

  tbody = (v) ->
    return v.domain.children( 'tbody' ).first()

  station_info_rows = (v) ->
    return tbody(v).children( 'tr.station_info_row' )

  set_width_of_station_info_domain: ->
    station_info_rows(@).each ->
      s = new TravelTimeInfoTableStationInfoRow( $( this ) )
      s.process()
      return
    return

class TravelTimeInfoTableStationInfoRow

  constructor: ( @domain ) ->

  station_info_cell = (v) ->
    return v.domain.children( 'td.station_info' ).first()

  station_info_domain = (v) ->
    return station_info_cell(v).children( '.station_info_domain' ).first()

  process: ->
    s = new StationInfoProcessor( station_info_domain(@) )
    s.process()
    return

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
    d.set_css_attribute( 'width' , Math.ceil( d.max_width() ) )
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

  set_vartical_align_center = (v) ->
    _children = children(v)
    p1 = new DomainsCommonProcessor( _children )
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( _children , h )
    p2.process()
    v.domain.css( 'height' , h )
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
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( true )

  process: ->
    process_cars(@)
    process_height(@)
    return

  process_cars = (v) ->
    _max_height = max_outer_height_of_car_domains(v)
    cars(v).each ->
      c = new WomenOnlyCarSectionInfoCar( $( this ) , _max_height )
      c.process()
      return
    return

  process_height = (v) ->
    _h = max_outer_height_of_children(v)
    p = new DomainsVerticalAlignProcessor( v.domain.children() , _h )
    p.process()
    v.domain.css( 'height' , _h )
    return

class WomenOnlyCarSectionInfoCar

  constructor: ( @car , @max_height ) ->

  current_height = (v) ->
    return v.car.outerHeight( false )

  padding_top_and_bottom = (v) ->
    return ( v.max_height - current_height(v) ) * 0.5

  process: ->
    _padding_top_and_bottom = padding_top_and_bottom(@)
    @car.css( 'padding-top' , Math.ceil( _padding_top_and_bottom ) ).css( 'padding-bottom' , Math.floor( _padding_top_and_bottom ) )
    return
