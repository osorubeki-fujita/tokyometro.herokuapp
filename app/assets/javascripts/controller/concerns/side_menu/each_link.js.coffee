class SideMenuEachLink

  constructor: ( @domain , @class_name ) ->

  link = (v) ->
    return v.domain.children( 'a' ).first()

  link_domain = (v) ->
    return v.domain.children( v.class_name ).first()

  sub_domains_of_link_domain = (v) ->
    return link_domain(v).children()

  icon = (v) ->
    return link_domain(v).children( '.icon' ).first()

  has_icon_content = (v) ->
    return icon(v).children().length == 1

  has_font_awesome_icon = (v) ->
    return icon(v).children( 'i' ).length == 1

  has_image_icon = (v) ->
    return icon(v).children( 'img' ).length == 1

  icon_content = (v) ->
    return icon(v).children().first()

  text = (v) ->
    return link_domain(v).children( '.text' ).first()

  text_large = (v) ->
    return link_domain(v).children( '.text_large' ).first()

  sub_domains_of_text = (v) ->
    return text(v).children()

  sub_domains_of_text_large = (v) ->
    return text_large(v).children()

  has_text = (v) ->
    return ( link_domain(v).children( '.text' ).length > 0 )

  has_text_large = (v) ->
    return ( link_domain(v).children( '.text_large' ).length > 0 )

  has_sub_domains_of_text = (v) ->
    return ( sub_domains_of_text(v).length > 0 )

  has_sub_domains_of_text_large = (v) ->
    return ( sub_domains_of_text_large(v).length > 0 )

  text_ja = (v) ->
    return text(v).children( '.text_ja' ).first()

  text_en = (v) ->
    return text(v).children( '.text_en' ).first()

  process: ->
    set_position_of_icon(@)
    process_text(@)
    return

  set_position_of_icon = (v) ->
    if has_icon_content(v)
      _icon = icon(v)
      p = new DomainsVerticalAlignProcessor( _icon.children() , _icon.outerHeight( false ) )
      p.process()
    return

  process_text = (v) ->
    if has_text(v) or has_text_large(v)
      _max_outer_height_of_sub_domains = max_outer_height_of_sub_domains(v)
      set_vertical_align_of_sub_domains( v , _max_outer_height_of_sub_domains )
    return

  sum_outer_height_of_text = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text(v) )
    return p.sum_outer_height( true )

  sum_outer_height_of_text_large = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text_large(v) )
    return p.sum_outer_height( true )

  max_outer_height_of_sub_domains = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_link_domain(v) )
    return p.max_outer_height( true )

  set_vertical_align_of_sub_domains = ( v , _max_outer_height_of_sub_domains ) ->
    p = new DomainsVerticalAlignProcessor( sub_domains_of_link_domain(v) , _max_outer_height_of_sub_domains )
    p.process()
    return

window.SideMenuEachLink = SideMenuEachLink