class LinksToRailwayLinePages

  constructor: ( @domain , @category ) ->

  link_domains = (v) ->
    return v.domain
      .children( 'li' )
      .not( '.title' )

  title_domains = (v) ->
    return v.domain
      .children( 'li.title' )

  on_fare_category = (v) ->
    return v.category is 'fare'

  process: ->
    process_when_on_fare_category(@)
    set_height_of_link_domains(@)
    return
  
  process_when_on_fare_category = (v) ->
    if on_fare_category(v)
      set_width_of_each_fare_link_domain(v)
      process_each_link_domain_on_fare_category(v)
    return

  set_width_of_each_fare_link_domain = (v) ->
    p = new RailwayLineAndStationMatrix()
    v.width_of_each_link_domain = p.width_of_each_normal_railway_line()
    return

  process_each_link_domain_on_fare_category = (v) ->
    # console.log 'LinksToRailwayLinePages\#process_each_link_domain_on_fare_category'
    # console.log 'width_of_each_link_domain: ' + v.width_of_each_link_domain
    # console.log link_domains(v)
    link_domains(v).each ->
      d = new LinkToRailwayLinePage( $( this ) , v.category , v.width_of_each_link_domain )
      d.set_text_width()
      d.process()
      return
    return

  set_height_of_link_domains = (v) ->
    p = new DomainsCommonProcessor( link_domains(v) )
    p.set_css_attribute( 'height' , p.max_height() )
    return

  #--------

  # max_height_of_link_domains = (v) ->
    # p = new DomainsCommonProcessor( link_domains(v) )
    # return p.max_height()

  # number_of_normal_railway_lines = (v) ->
    # p = new RailwayLineAndStationMatrix()
    # return p.number_of_normal_railway_lines

  # border_width = (v) ->
    # p = new RailwayLineAndStationMatrix()
    # return p.border_width

  # whole_height_of_link_domains = (v) ->
    # h = max_height_of_link_domains(v)
    # num = number_of_normal_railway_lines(v)
    # b_width = border_width(v)
    # return h * num + b_width * ( num + 1 )

  # whole_height_of_title_domains = (v) ->
    # _t = title_domains(v)
    # num = _t.length
    # p1 = new DomainsCommonProcessor( _t )
    # return p1.sum_inner_height() + border_width(v) * num

window.LinksToRailwayLinePages = LinksToRailwayLinePages

class LinkToRailwayLinePage

  constructor: ( @domain , @category , @width , @content_domain_name = '.railway_line_without_link , .with_link_to_railway_line_page' ) ->

  domain_of_content = (v) ->
    return v.domain
      .children( v.content_domain_name )
      .first()

  children_of_domain_of_content = (v) ->
    return domain_of_content(v)
      .children()

  sum_outer_width_of_children_of_domain_of_content = (v) ->
    c = children_of_domain_of_content(v)
    p = new DomainsCommonProcessor(c)
    return p.sum_outer_width( true )

  set_text_width: ->
    text = children_of_domain_of_content(@).filter( '.text' )
    p = new LengthToEven( text , true )
    p.set()
    return

  process: ->
    set_height_of_contents(@)
    set_width(@)
    return

  set_height_of_contents = (v) ->
    c = children_of_domain_of_content(v)
    p1 = new DomainsCommonProcessor(c)
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( c , h )
    p2.process()
    return

  set_width = (v) ->
    switch v.category
      when 'fare'
        set_width_normally(v)
      when 'passenger_survey'
        set_width_normally(v)
      when 'real_time_infos'
        set_width_normally(v)
    return
  
  set_width_normally = (v) ->
    v.domain.css( 'width' , v.width )
    return

window.LinkToRailwayLinePage = LinkToRailwayLinePage
