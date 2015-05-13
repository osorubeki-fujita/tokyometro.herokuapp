class ContentHeaderProcessor

  constructor: ( @domains ) ->

  icon_domains = (v) ->
    return v.domains.children( '.icon , .icons' )

  font_awesome_icons = (v) ->
    return icon_domains(v).children( 'i.fa' )

  width_of_icon_domains = (v) ->
     p = new DomainsCommonProcessor( icon_domains(v) )
     return p.max_outer_width( false )

  max_width_of_font_awesome_icons = (v) ->
     p = new DomainsCommonProcessor( font_awesome_icons(v) )
     return p.max_outer_width( false )

  width_of_icon_domains_new = (v) ->
    return Math.ceil( Math.max( width_of_icon_domains(v) , max_width_of_font_awesome_icons(v) ) )

  process: ->
    process_each_icon(@)
    process_each_domain(@)
    return

  process_each_icon = (v) ->
    _width_of_icon_domains_new = width_of_icon_domains_new(v)
    font_awesome_icons(v).each ->
      p = new DomainsHorizontalAlignProcessor( $( this ) , _width_of_icon_domains_new )
      p.process()
      return
    icon_domains(v).each ->
      $( this ).css( 'width' , _width_of_icon_domains_new )
      return
    return

  process_each_domain = (v) ->
    v.domains.each ->
      _title = new ContentHeader( $( this ) )
      _title.process()
      return
    return

window.ContentHeaderProcessor = ContentHeaderProcessor

class ContentHeader

  constructor: ( @domain ) ->

  icon_domain = (v) ->
    return v.domain.children( '.icon' ).first()

  font_awesome_icon = (v) ->
    return icon_domain(v).children( 'i.fa' ).first()

  text_domain = (v) ->
    return v.domain.children( '.text' ).first()

  text_en_top_domain = (v) ->
    return v.domain.children( '.text_en' ).first()

  buttons = (v) ->
    return v.domain.children( ".button , .update_button , .minimize_button , .size_button" ).first()

  link_info_to_train_location_of_each_railway_line = (v) ->
    return v.domain.children( '.link_info_to_train_location_of_each_railway_line' ).first()

  has_buttons = (v) ->
    return ( buttons(v).length > 0 )

  has_link_info_to_train_location_of_each_railway_line = (v) ->
    return ( v.domain.children( '.link_info_to_train_location_of_each_railway_line' ).length == 1 )

  max_height_of_icon_text_button = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( false )

  child_domains_except_for_link_info = (v) ->
    return v.domain.children().not( '.link_info_to_train_location_of_each_railway_line' )

  width_of_link_info = (v) ->
    p = new DomainsCommonProcessor( child_domains_except_for_link_info(v) )
    _w = p.sum_outer_width( true )
    outer_domain = link_info_to_train_location_of_each_railway_line(v).outerWidth( true ) - link_info_to_train_location_of_each_railway_line(v).width()
    w = v.domain.width() - ( _w + outer_domain )
    # console.log 'sum_outer_width: ' + _w
    # console.log 'outer_domain: ' + outer_domain
    # console.log 'w: ' + w
    return w

  process: ->
    process_link_info(@)
    process_text_domains(@)
    process_buttons(@)
    set_vertical_align(@)
    # set_height(@)
    return

  process_link_info = (v) ->
    if has_link_info_to_train_location_of_each_railway_line(v)
      p = new LinkInfoToTrainLocation( link_info_to_train_location_of_each_railway_line(v) )
      p.process( width_of_link_info(v) )
    return

  process_text_domains = (v) ->
    $.each [ text_domain(v) , text_en_top_domain(v) ] , ->
      if $(@).length > 0
        p = new LengthToEven( $(@) )
        p.set()
      return
    return

  process_buttons = (v) ->
    if has_buttons(v)
      buttons(v).each ->
        b = new ButtonProcessor( $( this ) )
        b.process()
        return
    return

  set_vertical_align = (v) ->
    h = max_height_of_icon_text_button(v)
    p = new DomainsVerticalAlignProcessor( v.domain.children() , h , 'middle' )
    p.process()
    return

  # set_height = (v) ->
    # h = max_height_of_icon_and_text(v)
    # v.domain.css( 'height' , h )
    # return

class LinkInfoToTrainLocation

  constructor: ( @domain ) ->

  icon = (v) ->
    return v.domain.children( '.icon' ).first()

  text = (v) ->
    return v.domain.children( '.text' ).first()

  font_awesome_icon = (v) ->
    return icon(v).children( 'i' ).first()

  process: (w) ->
    set_width(@,w)
    set_margin_of_font_awesome_icon(@)
    set_width_of_text(@)

    p1 = new DomainsCommonProcessor( @domain.children() )
    p2 = new DomainsVerticalAlignProcessor( @domain.children() , p1.max_outer_height( true ) ,'middle' )
    p2.process()
    return

  set_width = ( v , w ) ->
    v.domain.css( 'width' , w )
    return

  set_margin_of_font_awesome_icon = (v) ->
    p1 = new DomainsVerticalAlignProcessor( font_awesome_icon(v) , icon(v).height() , 'middle' )
    p2 = new DomainsHorizontalAlignProcessor( font_awesome_icon(v) , icon(v).width() , 'center' )
    p1.process()
    p2.process()
    return

  set_width_of_text = (v) ->
    w = width_of_text(v)
    text(v).css( 'width' , w )
    return

  width_of_text = (v) ->
    return v.domain.width() - icon(v).outerWidth( true ) - ( text(v).outerWidth( true ) - text(v).width() )