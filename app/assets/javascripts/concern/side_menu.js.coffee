class SideMenuProcessor

  constructor: ( @domain = $( '#side_menu' ) ) ->

  links_to_main_contents = (v) ->
    return v.domain.children( 'ul#links_to_main_contents' )

  links_to_documents = (v) ->
    return v.domain.children( 'ul#links_to_documents' )

  links_to_other_websites = (v) ->
    return v.domain.children( 'ul#links_to_other_websites' )

  process: ->
    process_links_to_main_contents(@)
    process_links_to_documents(@)
    process_links_to_other_websites(@)
    return

  process_links_to_main_contents = (v) ->
    links_to_main_contents(v).children( 'li' ).each ->
      li = new SideMenuEachLink( $( this ) , '.link_to_content' )
      li.process()
      return
    return

  process_links_to_documents = (v) ->
    links_to_documents(v).children( 'li' ).each ->
      li = new SideMenuEachLink( $( this ) , '.link_to_document' )
      li.process()
      return
    return

  process_links_to_other_websites = (v) ->
    links_to_other_websites(v).children( 'li' ).each ->
      li = new SideMenuEachLink( $( this ) , '.link_to_other_website' )
      li.process()
      return
    return

window.SideMenuProcessor = SideMenuProcessor

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
      p1 = new DomainsVerticalAlignProcessor( icon(v).children() , _icon.outerHeight( false ) , 'middle' )
      p1.process()

      p2 = new DomainsHorizontalAlignProcessor( icon(v).children() , _icon.outerWidth( false ) , 'center' )
      p2.process()
    return

  process_text = (v) ->
    if has_text(v) or has_text_large(v)
      set_height_of_text(v)

      _max_outer_height_of_sub_domains = max_outer_height_of_sub_domains(v)
      set_vertical_align_of_sub_domains( v , _max_outer_height_of_sub_domains )
      set_height_of_link_domain( v , _max_outer_height_of_sub_domains )

      set_height_of_whole_domain(v)
    return

  sum_outer_height_of_text = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text(v) )
    return p.sum_outer_height( true )

  sum_outer_height_of_text_large = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text_large(v) )
    return p.sum_outer_height( true )

  set_height_of_text = (v) ->
    if has_text(v) and has_sub_domains_of_text(v)
      text(v).css( 'height' , sum_outer_height_of_text(v) )
    else if has_text_large(v) and has_sub_domains_of_text_large(v)
      text_large(v).css( 'height' , sum_outer_height_of_text_large(v) )
    return

  max_outer_height_of_sub_domains = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_link_domain(v) )
    return p.max_outer_height( true )

  set_vertical_align_of_sub_domains = ( v , _max_outer_height_of_sub_domains ) ->
    p = new DomainsVerticalAlignProcessor( sub_domains_of_link_domain(v) , _max_outer_height_of_sub_domains , 'middle' )
    p.process()
    return

  set_height_of_link_domain = ( v , _max_outer_height_of_sub_domains ) ->
    link_domain(v).css( 'height' , _max_outer_height_of_sub_domains )
    return

  set_height_of_whole_domain = (v) ->
    v.domain.css( 'height' , link_domain(v).outerHeight( true ) )
    return