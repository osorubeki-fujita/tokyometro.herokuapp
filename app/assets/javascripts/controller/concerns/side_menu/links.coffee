class SideMenuLinks

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
    process_links( v , links_to_main_contents(v) , '.link_to_content' )
    return

  process_links_to_documents = (v) ->
    process_links( v , links_to_documents(v) , '.link_to_document' )
    return

  process_links_to_other_websites = (v) ->
    process_links( v , links_to_other_websites(v) , '.link_to_other_website' )
    return

  process_links = ( v , ul_domain , class_name ) ->
    li_domains = ul_domain.children( 'li' )
    li_domains.each ->
      li = new SideMenuEachLink( $( this ) , class_name )
      li.process()
      return
    return

window.SideMenuLinks = SideMenuLinks
