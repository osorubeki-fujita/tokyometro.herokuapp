class BottomContent
  constructor: ( @domain = $( 'div#bottom_content' ) ) ->

  links = (v) ->
    return v.domain.children( '.links' )

  margin_of_links = ( v , p ) ->
    return ( v.domain.outerHeight( true ) - p.sum_outer_height( true ) ) * 0.5

  processor_of_links = (v) ->
    return new DomainsCommonProcessor( links(v) )

  process: ->
    p = processor_of_links(@)
    _margin_of_links = margin_of_links(@,p)
    [ 'margin-top' , 'margin-bottom' ].each ->
      p.set_css_attribute( $( this ) , _margin_of_links )
      return
    return