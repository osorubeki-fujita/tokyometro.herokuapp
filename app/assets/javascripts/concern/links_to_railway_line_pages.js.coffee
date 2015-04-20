class LinksToRailwayLinePages

  constructor: ( @domain , @controller ) ->

  link_domains = (v) ->
    # return v.domain.children( 'li.link_to_railway_line_page' )
    return v.domain.children( 'li' ).not( '.title' )

  title_domains = (v) ->
    return v.domain.children( 'li.title' )

  process: ->
    set_width_of_each_fare_link_domain(@)
    process_each_link_domain(@)
    set_height_of_link_domains(@)
    set_height_of_domain(@)
    return

  set_width_of_each_fare_link_domain = (v) ->
    if v.controller is 'fare'
      p = new RailwayLineAndStationMatrix()
      v.width_of_each_link_domain = p.width_of_each_normal_railway_line()
    return

  process_each_link_domain = (v) ->
    if v.controller is 'fare'
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

  set_height_of_domain = (v) ->
    if v.controller is 'fare'
      h = max_height_of_link_domains(v)
      p = new RailwayLineAndStationMatrix()
      rows = p.number_of_rows_of_normal_railway_lines_in_railway_line_matrix()
      h_whole = h * rows + p.border_width * ( rows + 1 )
      v.domain.css( 'height' , h_whole )
    return

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
    set_height_of_domain(@)
    set_width(@)
    return

  set_height_of_contents = (v) ->
    c = children_of_domain_of_content(v)
    p1 = new DomainsCommonProcessor(c)
    h = p1.max_outer_height( true )
    p2 = new DomainsVerticalAlignProcessor( c , h , 'middle' )
    p2.process()
    domain_of_content(v).css( 'height' , h )
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

class AnimationForRailwayLineDomains

  constructor: ( @domains ) ->
    console.log 'constructor'
    return
  
  survey_year_domains = (v) ->
    return v.domains.children( 'li.survey_year' )
  
  railway_line_domain_for_survey_year_domain = ( survey_year_domain ) ->
    return survey_year_domain.parent().children( 'li.railway_line' )

  process: ->
    console.log 'process'
    process_for_hover(@)
    return

  process_for_hover = (v) ->
    console.log 'process_for_hover'

    survey_year_domains(v).hover ->
      console.log 'onMouse begin'
      railway_line_domain_for_survey_year_domain( $( this ) ).queue -> # 'add_class' , ->
        console.log 'add_class'
        console.log '  classes: ' + $( this ).attr( 'class' )
        if $( this ).hasClass( 'hover' )
          console.log '  has_class \'hover\''
          $( this ).addClass( 'hover_x' )
        else
          $( this ).addClass( 'hover' , { duration: 2000 , children: true } )
        return
      # console.log railway_line_domain_for_survey_year_domain( $( this ) ).queue( 'add_class' )
      railway_line_domain_for_survey_year_domain( $( this ) ).dequeue()
      console.log 'onMouse end (2000ms)'
      return

    , ->
      console.log 'outMouse'

      window.setInterval ->
        return
      , 2000

      railway_line_domain_for_survey_year_domain( $( this ) ).queue -> # 'remove_class' , ->
        console.log 'remove_class begin'
        console.log '  classes: ' + $( this ).attr( 'class' )
        $( this ).addClass( 'hover_x' )
        $( this ).removeClass( 'hover' , { duration: 8000 , children: true } )
        if $( this ).hasClass( 'hover_x' )
          console.log '  has_class \'hover_x\''
          $( this ).removeClass( 'hover_x' )
        else
          $( this ).removeClass( 'hover' , { duration: 8000 , children: true } )
        console.log 'remove_class end'
        return
      # console.log railway_line_domain_for_survey_year_domain( $( this ) ).queue( 'remove_class' )
      railway_line_domain_for_survey_year_domain( $( this ) ).dequeue()
      return
    return

$(document).on 'page:change', ->

  $ ->

    add_class_hover = ->
      $( this ).addClass( 'hover' , { duration: 200 , children: true } )
      # console.log 'add_class_hover'
      return

    remove_class_hover = ->
      $( this ).removeClass( 'hover' , { duration: 800 , children: true } )
      # console.log 'remove_class_hover'
      return

    $( 'ul#links_to_main_contents , ul#links_to_other_websites , ul#links_to_documents , ul#links_to_document_pages' )
      .children( 'li' )
      .hover( add_class_hover , remove_class_hover )

    $( 'ul#links_to_year_pages' )
      .find( 'li.tokyo_metro' )
      .hover( add_class_hover , remove_class_hover )

    $( '#fare_contents' )
      .children( 'ul#links_to_railway_line_pages' )
      .find( 'li.railway_line' )
      .not( '.title' )
      .hover( add_class_hover , remove_class_hover )

    railway_line_domains_in_links_to_passenger_survey = $( 'ul#links_to_passenger_survey_pages' )
      .children( 'ul#links_to_railway_line_pages , ul#links_to_railway_line_pages_of_this_station' )
      .children( 'ul.each_railway_line' )

    railway_line_domains_in_links_to_passenger_survey
      .children( 'li.railway_line , li.survey_year' )
      .hover( add_class_hover , remove_class_hover )

    if railway_line_domains_in_links_to_passenger_survey.length > 0
      animation_for_railway_line_domain = new AnimationForRailwayLineDomains( railway_line_domains_in_links_to_passenger_survey )
      animation_for_railway_line_domain.process()
      return

    return

  return