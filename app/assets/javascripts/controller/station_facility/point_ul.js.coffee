#-------------------------------- 出入口情報の処理

class StationFacilityPointUl

  constructor: ( @domain = $( 'ul#exits' ) ) ->

  li_domains = (v) ->
    return v.domain.children( 'li' )

  #-------- Code (all)

  codes_in_li_domains = (v) ->
    return li_domains(v).children( '.code' )

  #-------- EV

  elevator_domains = (v) ->
    return li_domains(v).find( '.code.elevator' )

  has_elevator_domains = (v) ->
    return elevator_domains(v).length > 0

  #-------- Code (normal)

  normal_code_domains = (v) ->
    return li_domains(v).find( '.code' ).not( '.elevator' )

  has_normal_code_domains = (v) ->
    return normal_code_domains(v).length > 0

  #-------- Close

  has_close_infos = (v) ->
    return close_infos(v).length > 0

  close_infos = (v) ->
    return li_domains(v).find( '.close' )

  process: ->
    set_length_of_elevator_domains(@)
    set_length_of_normal_code_domains(@)
    set_length_of_close_info(@)
    process_height_of_li_children(@)
    process_width_of_codes_in_li_domains(@)

    process_width_of_li_domain(@)
    process_height_of_li_domain(@)
    process_width_of_ul_domain(@)
    return

  set_length_of_elevator_domains = (v) ->
    if has_elevator_domains(v)
      elevator_domains(v).each ->
        p = new StationFacilityPointElevator( $(@) )
        p.set_length()
        return
    return

  set_length_of_normal_code_domains = (v) ->
    if has_normal_code_domains(v)
      normal_code_domains(v).each ->
        p = new StationFacilityPointCode( $(@) )
        p.set_length()
        return
    return

  set_length_of_close_info = (v) ->
    if has_close_infos(v)
      close_infos(v).each ->
        p = new StationFacilityPointCloseInfo( $(@) )
        p.process()
        return
    return

  process_height_of_li_children = (v) ->
    h = max_outer_height_of_li_children(v)
    li_domains(v).children().each ->
      padding_top_or_bottom = ( h - $(@).height() ) * 0.5
      $(@).css( 'padding-top' , Math.ceil( padding_top_or_bottom ) )
      $(@).css( 'padding-bottom' , Math.floor( padding_top_or_bottom ) )
      return
    return

  process_width_of_codes_in_li_domains = (v) ->
    w = max_sum_outer_width_of_code_in_li_domains(v)
    # console.log 'max_sum_outer_width_of_code_in_li_domains: ' + w
    li_domains(v).each ->
      p = new StationFacilityPointCode( $(@).children( '.code' ).first() )
      p.set_padding_left_and_right(w)
      return
    return

  process_width_of_li_domain = (v) ->
    w = max_sum_outer_width_of_li_children(v)
    li_domains(v).each ->
      $(@).css( 'width' , w )
      return
    return

  process_height_of_li_domain = (v) ->
    h = max_outer_height_of_li_children(v)
    # console.log 'max_outer_height_of_li_children: ' + h
    li_domains(v).each ->
      $(@).css( 'height' , h )
      return
    return

  process_width_of_ul_domain = (v) ->
    w_ul = width_of_ul(v)
    v.domain.css( 'width' , w_ul )
    return

  max_outer_height_of_li_children = ( v , setting = false ) ->
    p = new DomainsCommonProcessor( li_domains(v).children() )
    return p.max_outer_height( setting )

  max_sum_outer_width_of_code_in_li_domains = (v) ->
    w = 0
    li_domains(v).each ->
      p = new StationFacilityPointCode( $(@).children( '.code' ).first() )
      w_of_this_li = p.width()
      # console.log 'w_of_this_li: ' + w_of_this_li
      w = Math.max( w , w_of_this_li )
      return
    return w

  max_sum_outer_width_of_li_children = (v) ->
    w = 0
    li_domains(v).each ->
      p = new DomainsCommonProcessor( $(@).children() )
      w_of_this_li = p.sum_outer_width( true )
      w = Math.max( w , w_of_this_li )
      return
    return w

  max_outer_width_of_li = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    return p.max_outer_width( true )

  width_of_ul = (v,w) ->
    if to_scroll_ul(v)
      # console.log 'scroll'
      w_of_ul = max_outer_width_of_li(v) + 18
    else
      w_of_ul = max_outer_width_of_li(v)
    return w_of_ul

  to_scroll_ul = (v) ->
    return height_of_ul_domain(v) < height_of_ul_whole(v)

  height_of_ul_whole = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    return p.sum_outer_height( true )

  height_of_ul_domain = (v) ->
    return parseInt( v.domain.css( 'height' ) , 10 )

window.StationFacilityPointUl = StationFacilityPointUl

class StationFacilityPointElevator

  constructor: ( @domain ) ->

  #-------- ev

  ev_domains = (v) ->
    return v.domain.children( '.ev' )

  has_ev_domains = (v) ->
    return ev_domains(v).length > 0

  ev_domain = (v) ->
    return ev_domains(v).first()

  #-------- code

  codes = (v) ->
    return v.domain.children( '.code' )

  has_codes = (v) ->
    return codes(v).length > 0

  code = (v) ->
    return codes(v).first()

  set_length: ->
    # console.log 'StationFacilityPointEv'
    set_length_of_ev_domain(@)
    set_length_of_code(@)
    set_height_of_this_domain(@)
    set_width_of_this_domain(@)
    return

  set_length_of_ev_domain = (v) ->
    if has_ev_domains(v)
      p = new LengthToEven( ev_domain(v) , true )
      p.set()
    return

  set_length_of_code = (v) ->
    if has_codes(v)
      # console.log '---- set_length_of_code'
      # console.log code(v)
      p = new StationFacilityPointCode( code(v) )
      p.set_length()
    return

  set_height_of_this_domain = (v) ->
    h = max_outer_height_of_children(v)
    p = new DomainsVerticalAlignProcessor( v.domain.children() , h )
    p.process()
    return

  set_width_of_this_domain = (v) ->
    v.domain.css( 'width' , sum_outer_height_of_children(v) )
    return

  sum_outer_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.sum_outer_width( true )

  max_outer_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( false )

class StationFacilityPointCode

  constructor: ( @domain ) ->

  has_class_text_en = (v) ->
    return v.domain.hasClass( 'text_en' )

  has_children = (v) ->
    return v.domain.children().length > 0

  has_no_child = (v) ->
    return not has_children(v)

  set_length: ->
    if has_class_text_en(@) and has_no_child(@)
      # console.log @domain
      p = new LengthToEven( @domain , true )
      p.set()
    else if has_children(@)
      set_length_of_children(@)
      set_width_of_domain(@)
      set_vertical_align_of_children(@)
    return

  set_length_of_children = (v) ->
    v.domain.children().each ->
      p = new LengthToEven( $(@) , true )
      p.set()
      return
    return

  set_width_of_domain = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    w = p.sum_outer_width( true )
    v.domain.css( 'width' , w )
    return

  set_vertical_align_of_children = (v) ->
    h = max_outer_height_of_children(v)
    p = new DomainsVerticalAlignProcessor( v.domain.children() , h )
    p.process()
    return

  max_outer_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( false )

  width: ->
    if has_no_child(@)
      w = @domain.width()
    else
      p = new DomainsCommonProcessor( @domain.children() )
      w = p.sum_outer_width( true )
    return w

  set_padding_left_and_right: (w) ->
    default_padding_left = parseInt( @domain.css( 'padding-left' ) , 10 )
    default_padding_right = parseInt( @domain.css( 'padding-right' ) , 10 )
    padding_left_or_right = ( w - @domain.width() ) * 0.5 + Math.max( default_padding_left , default_padding_right )
    # console.log padding_left_or_right
    @domain.css( 'padding-left' , Math.ceil( padding_left_or_right ) )
    @domain.css( 'padding-right' , Math.floor( padding_left_or_right ) )
    return

class StationFacilityPointCloseInfo

  constructor: ( @domain ) ->

  icon = (v) ->
    return v.domain.children( '.icon' ).first()

  text = (v) ->
    return v.domain.children( '.text' ).first()

  max_outer_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.domain.children() )
    return p.max_outer_height( false )

  process: ->
    process_icon_size(@)
    process_text_size(@)
    set_vertical_align(@)
    return

  process_icon_size = (v) ->
    p = new LengthToEven( icon(v) )
    p.set()
    return

  process_text_size = (v) ->
    text(v).children().each ->
      # console.log 'width: ' + $(@).width()
      p = new LengthToEven( $(@) , true )
      p.set()
      return
    return

  set_vertical_align = (v) ->
    h = max_outer_height_of_children(v)
    p = new DomainsVerticalAlignProcessor( v.domain.children() , h )
    p.process()
    return