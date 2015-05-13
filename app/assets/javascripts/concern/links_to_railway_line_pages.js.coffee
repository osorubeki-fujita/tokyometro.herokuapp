class LinksToRailwayLinePages

  constructor: ( @domain , @controller ) ->

  link_domains = (v) ->
    # return v.domain.children( 'li.link_to_railway_line_page' )
    return v.domain.children( 'li' ).not( '.title' )

  title_domains = (v) ->
    return v.domain.children( 'li.title' )
  
  on_fare_controller = (v) ->
    return v.controller is 'fare'

  process: ->
    set_width_of_each_fare_link_domain(@)
    process_each_link_domain(@)
    set_height_of_link_domains(@)
    return

  set_width_of_each_fare_link_domain = (v) ->
    if on_fare_controller(v)
      p = new RailwayLineAndStationMatrix()
      v.width_of_each_link_domain = p.width_of_each_normal_railway_line()
    return

  process_each_link_domain = (v) ->
    if on_fare_controller(v)
      link_domains(v).each ->
        d = new LinkToRailwayLinePage( $( this ) , v.controller , v.width_of_each_link_domain )
        d.process()
      return
    return

  max_height_of_link_domains = (v) ->
    p = new DomainsCommonProcessor( link_domains(v) )
    return p.max_height()

  set_height_of_link_domains = (v) ->
    p = new DomainsCommonProcessor( link_domains(v) )
    p.set_css_attribute( 'height' , p.max_height() )
    return
  
  number_of_normal_railway_lines = (v) ->
    p = new RailwayLineAndStationMatrix()
    return p.number_of_normal_railway_lines
  
  border_width = (v) ->
    p = new RailwayLineAndStationMatrix()
    return p.border_width
  
  whole_height_of_link_domains = (v) ->
    h = max_height_of_link_domains(v)
    num = number_of_normal_railway_lines(v)
    b_width = border_width(v)
    return h * num + b_width * ( num + 1 )
  
  whole_height_of_title_domains = (v) ->
    _t = title_domains(v)
    num = _t.length
    p1 = new DomainsCommonProcessor( _t )
    return p1.sum_inner_height() + border_width(v) * num
    # return p1.sum_inner_height() + border_width(v) * ( num + 1 )

window.LinksToRailwayLinePages = LinksToRailwayLinePages

class LinkToRailwayLinePage

  constructor: ( @domain , @controller , @width , @content_domain_name = '.link_to_railway_line_page' ) ->

  domain_of_content = (v) ->
    return v.domain.children( v.content_domain_name ).first()

  children_of_domain_of_content = (v) ->
    return domain_of_content(v).children()
  
  sum_outer_width_of_children_of_domain_of_content = (v) ->
    c = children_of_domain_of_content(v)
    p = new DomainsCommonProcessor(c)
    return p.sum_outer_width( true )

  process: ->
    set_height_of_contents(@)
    # set_height_of_domain(@)
    set_width(@)
    return

  set_height_of_contents = (v) ->
    c = children_of_domain_of_content(v)
    p1 = new DomainsCommonProcessor(c)
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( c , h , 'middle' )
    p2.process()
    # domain_of_content(v).css( 'height' , h )
    return

  set_height_of_domain = (v) ->
    v.domain.css( 'height' , domain_of_content(v).outerHeight( true ) )
    return

  set_width = (v) ->
    switch v.controller
      when 'fare'
        v.domain.css( 'width' , v.width )
      when 'passenger_survey'
        v.domain.css( 'width' , v.width )
    return

window.LinkToRailwayLinePage = LinkToRailwayLinePage