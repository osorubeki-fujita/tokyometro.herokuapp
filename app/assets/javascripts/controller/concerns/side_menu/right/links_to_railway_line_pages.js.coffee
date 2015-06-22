class LinksToRailwayLinePages

  constructor: ( @domain , @controller , @class_name_of_li_sub_content , @selector_for_text_domain ) ->

  links_to_year_pages = (v) ->
    return v.domain
      .children( 'ul#links_to_year_pages' )

  has_links_to_year_pages = (v) ->
    return links_to_year_pages(v).length > 0

  ul_operator_domains: ->
    if has_links_to_year_pages(@)
      d = links_to_year_pages(@).children( 'ul.operator' )
    else
      d = null
    return d

  has_links_to_railway_line_pages_of_this_station = (v) ->
    return v.links_to_railway_line_pages_of_this_station().length > 0

  has_links_to_railway_line_pages = (v) ->
    return links_to_railway_line_pages(v).length > 0

  links_to_railway_line_pages: ->
    return @domain
      .children( 'ul#links_to_railway_line_pages' )

  li_operator_domain: ->
    _ul_operator_doms = @.ul_operator_domains()
    if _ul_operator_doms?
      d = _ul_operator_doms.children( 'li.tokyo_metro' )
    else
      d = null
    return d

  ul_each_railway_line_domains: ->
    ary = []
    $.each [ @.links_to_railway_line_pages_of_this_station() , @.links_to_railway_line_pages() ] , ->
      group = @
      if group?
        $(@).children( 'ul.each_railway_line' ).each ->
          ary.push( $(@) )
          return
    return ary

  main_content_in_link_to_operator_page = (v) ->
    _li_operator_dom = v.li_operator_domain()
    if _li_operator_dom?
      d = _li_operator_dom.children( '.link_to_operator_page' )
    else
      d = null
    return d

  domains_of_railway_line_name = (v) ->
    ary = []
    $.each v.li_railway_line_domains() , ->
      $(@).children( '.railway_line_without_link , .with_link_to_railway_line_page' ).each ->
        ary.push( $(@) )
        return
      return
    return ary

  contents_in_domains_related_to_railway_lines = (v) ->
    ary = []
    $.each domains_of_railway_line_name(v) , ->
      ary.push( $(@) )

    d = main_content_in_link_to_operator_page(v)
    if d?
      $.each d , ->
        ary.push( $(@) )
        return
    return ary

  li_sub_domains = (v) ->
    ary = []

    $.each v.ul_each_railway_line_domains() , ->
      $( this ).children( "li.#{ v.class_name_of_li_sub_content }" ).each ->
        ary.push( $( this ) )
        return
      return

    _ul_operator_doms = v.ul_operator_domains()
    if _ul_operator_doms?
      _ul_operator_doms.each ->
        $( this ).children( "li.#{ v.class_name_of_li_sub_content }" ).each ->
          ary.push( $( this ) )
          return
        return

    return ary

  li_railway_line_domains: ->
    ary = []
    $.each @.ul_each_railway_line_domains() , ->
      $(@).children( 'li.railway_line' ).each ->
        ary.push( $(@) )
        return
      return
    return ary

  process: ->
    @.set_domain_infos()
    process_by_processor(@)
    return

  process_by_processor = (v) ->
    p = new LinksToRailwayLinePagesProcessor( v.controller , v.domain_infos , v.class_name_of_li_sub_content , length_infos(v) , max_number_of_li_domains_for_each_ul(v) )
    p.process()
    return
  
  length_infos = (v) ->
    obj =
      width_of_whole_domain: width_of_whole_domain(v)
      border_width_of_li_domains: max_border_width_of_li_domains(v)
      inner_width_of_li_sub_content: max_inner_width_of_li_sub_content(v)
      max_outer_width_of_contents_in_domains_related_to_railway_lines: max_outer_width_of_contents_in_domains_related_to_railway_lines(v)
    return obj

  width_of_whole_domain = (v) ->
    return v.domain.width()

  max_border_width_of_li_domains = (v) ->
    p = new DomainsCommonProcessor( v.li_domains() )
    return p.max_border_width()

  max_inner_width_of_li_sub_content = (v) ->
    p = new DomainsCommonProcessor( li_sub_domains(v) )
    return p.max_inner_width()

  max_outer_width_of_contents_in_domains_related_to_railway_lines = (v) ->
    _contents = contents_in_domains_related_to_railway_lines(v)
    p = new DomainsCommonProcessor( $( _contents ) )
    return p.max_outer_width( true )
  
  #--------

  max_number_of_li_domains_for_each_ul = (v) ->
    n = 0
    $.each [ v.ul_each_railway_line_domains() , v.ul_operator_domains() ] , ->
      if @? and typeof(@) isnt 'undefined'
        ul_group = $(@)
        ul_group.each ->
          ul = $(@)
          n = Math.max( n , ul.children( 'li' ).length )
          return
      return
    return n


class LinksToPassengerSurveyPages extends LinksToRailwayLinePages

  constructor: ( @domain ) ->
    super( @domain , 'passenger_survey' , 'survey_year' , 'img' )

  titles = (v) ->
    return v.domain
      .children( 'ul' )
      .children( 'li.title' )

  links_to_railway_line_pages_of_this_station: ->
    return @domain
      .children( 'ul#links_to_railway_line_pages_of_this_station' )

  li_domains: ->
    return @domain.find( "li.railway_line , li.tokyo_metro , li.#{ @class_name_of_li_sub_content }" )

  domain_groups_related_to_railway_lines = (v) ->
    return [ v.li_railway_line_domains() , v.li_operator_domain() ]
  
  set_domain_infos: ->
    obj =
      domain_groups_related_to_railway_lines: domain_groups_related_to_railway_lines(@)
      li_railway_line_domains: @.li_railway_line_domains()
      ul_each_railway_line_domains: @.ul_each_railway_line_domains()

      titles: titles(@)
      li_operator_domain: @.li_operator_domain()
      ul_operator_domains: @.ul_operator_domains()
    
    @domain_infos = obj
    return

window.LinksToPassengerSurveyPages = LinksToPassengerSurveyPages


class LinksToRealTimeInfoPages extends LinksToRailwayLinePages

  constructor: ( @domain ) ->
    super( @domain , 'real_time_infos' , 'each_controller' )

  li_domains: ->
    return @domain.find( "li.railway_line , li.#{ @class_name_of_li_sub_content }" )

  domain_groups_related_to_railway_lines = (v) ->
    return [ v.li_railway_line_domains() ]

  set_domain_infos: ->
    obj =
      domain_groups_related_to_railway_lines: domain_groups_related_to_railway_lines(@)
      li_railway_line_domains: @.li_railway_line_domains()
      ul_each_railway_line_domains: @.ul_each_railway_line_domains()
    @domain_infos = obj
    return

  links_to_railway_line_pages_of_this_station: ->
    return null

window.LinksToRealTimeInfoPages = LinksToRealTimeInfoPages


class LinksToRailwayLinePagesProcessor

  constructor: ( @controller , @domain_infos , @class_name_of_li_sub_content , @length_infos , @max_number_of_li_domains , @selector_for_text_domain ) ->

  process: ->
    set_width_of_railway_line_and_operator_domains_to_this_object(@)

    set_width_of_text_domain_in_domain_groups_related_to_railway_lines(@)
    process_titles(@)
    process_railway_line_and_operator_domain(@)
    set_length_of_each_sub_domain(@)
    return

  set_width_of_railway_line_and_operator_domains_to_this_object = (v) ->
    w1 = v.length_infos.max_outer_width_of_contents_in_domains_related_to_railway_lines
    w2 = v.length_infos.width_of_whole_domain - ( v.length_infos.inner_width_of_li_sub_content * ( v.max_number_of_li_domains - 1 ) + v.length_infos.border_width_of_li_domains * ( v.max_number_of_li_domains + 1 ) )
    w = Math.max( w1 , w2 )
    v.length_infos.width_of_railway_line_and_operator_domains = w
    return

  set_width_of_text_domain_in_domain_groups_related_to_railway_lines = (v) ->
    for group in v.domain_infos.domain_groups_related_to_railway_lines
      li_domain_group = $( group )
      $.each li_domain_group , ->
        l = new LinkToRailwayLinePage( $(@) , v.controller )
        l.set_text_width()
        return
    return

  process_titles = (v) ->
    t = v.domain_infos.titles
    if t?
      t.each ->
        paddings_left_and_right = $(@).innerWidth() - $(@).width()
        $(@).css( 'width' , v.length_infos.width_of_whole_domain - paddings_left_and_right )
        return
    return

  process_railway_line_and_operator_domain = (v) ->
    $.each v.domain_infos.li_railway_line_domains , ->
      p = new LinkToRailwayLinePage( $(@) , v.controller , v.length_infos.width_of_railway_line_and_operator_domains , '.with_link_to_railway_line_page , .railway_line_without_link' )
      p.process()
      return

    if v.domain_infos.li_operator_domain? or ( typeof( v.domain_infos.li_operator_domain ) isnt 'undefined' )
      $.each v.domain_infos.li_operator_domain , ->
        p = new LinkToRailwayLinePage( $( this ) , v.controller , v.length_infos.width_of_railway_line_and_operator_domains , '.link_to_operator_page' )
        p.process()
        return

    return

  set_length_of_each_sub_domain = (v) ->
    $.each v.domain_infos.ul_each_railway_line_domains , ->
      p = new LinkToSubConentPagesInEachUl( $(@) , 'railway_line' , v.class_name_of_li_sub_content , v.length_infos.inner_width_of_li_sub_content , v.selector_for_text_domain )
      p.process()
      return

    if v.domain_infos.ul_operator_domains? or ( typeof( v.domain_infos.ul_operator_domains ) isnt 'undefined' )
      v.domain_infos.ul_operator_domains.each ->
        p = new LinkToSubConentPagesInEachUl( $(@) , 'tokyo_metro' , v.class_name_of_li_sub_content , v.length_infos.inner_width_of_li_sub_content , v.selector_for_text_domain )
        p.process()
        return
    return

class LinkToSubConentPagesInEachUl

  constructor: ( @domain , @class_name_of_li_main_content , @class_name_of_li_sub_content , @inner_width_of_li_sub_content , @selector_for_text_domain = 'p.text_en' ) ->
    # console.log '----'
    # console.log @domain
    # console.log @class_name_of_li_sub_content

  main_content = (v) ->
    return v.domain
      .children( "li.#{ v.class_name_of_li_main_content }" )
      .first()

  height_of_main_content = (v) ->
    return main_content(v)
      .height()

  sub_contents = (v) ->
    return v.domain
      .children( "li.#{ v.class_name_of_li_sub_content }" )

  process: ->
    set_height_of_each_li_domain_to_this_object(@)
    set_height_to_sub_contents(@)
    set_vertical_align_of_texts_and_width(@)
    return

  set_height_of_each_li_domain_to_this_object = (v) ->
    v.height_of_each_li_domain = height_of_main_content(v)
    return

  set_height_to_sub_contents = (v) ->
    p = new DomainsCommonProcessor( sub_contents(v) )
    p.set_css_attribute( 'height' , v.height_of_each_li_domain )
    return

  set_vertical_align_of_texts_and_width = (v) ->
    sub_contents(v).each ->
      sub_content = $(@)
      text_content = $(@).children( v.selector_for_text_domain ).first()
      p = new DomainsVerticalAlignProcessor( text_content , v.height_of_each_li_domain )
      p.process()
      sub_content.css( 'width' , v.inner_width_of_li_sub_content )
      return
    return
