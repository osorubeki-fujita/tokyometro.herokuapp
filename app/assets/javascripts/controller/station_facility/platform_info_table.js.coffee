#-------------------------------- プラットホーム情報の処理

class StationFacilityPlatformInfoTable

  constructor: ( @domain ) ->

  transfer_infos = (v) ->
    return v.domain.find( 'li.transfer_info' )

  process: ->
    process_transfer_infos(@)
    return

  # 乗換情報の処理
  process_transfer_infos = (v) ->
    platform_infos = new StationFacilityTransferInfosInPlatformInfos( transfer_infos(v) )
    platform_infos.process()
    return

window.StationFacilityPlatformInfoTable = StationFacilityPlatformInfoTable

class StationFacilityTransferInfosInPlatformInfos

  constructor: ( @domains ) ->

  process: ->
    @domains.each ->
      info = new StationFacilityTransferInfoInPlatformInfo( $(@) )
      info.process()
    return

class StationFacilityTransferInfoInPlatformInfo

  constructor: ( @domain ) ->

  div_domain = (v) ->
    return v.domain.children( '.with_link_to_railway_line_page , .railway_line_with_no_link' )

  railway_line_code = (v) ->
    return div_domain(v).children( '.railway_line_code_32' ).first()

  railway_line_code_main = (v) ->
    return railway_line_code(v).children().first()

  railway_line_main_domain = (v) ->
    return div_domain(v).children( '.railway_line' ).first()

  text_domain = (v) ->
    return railway_line_main_domain(v).children( '.text' ).first()

  process: ->
    process_railway_line_main_domain(@)
    set_width_of_outer_domain(@)
    return

  process_railway_line_main_domain = (v) ->
    _railway_line_main_domain = railway_line_main_domain(v)
    p = new LengthToEven( _railway_line_main_domain , true )
    p.set( { min_width: 84 } )
    return

  set_width_of_outer_domain = (v) ->
    doms = div_domain(v).children()
    p1 = new DomainsCommonProcessor( doms )
    div_domain(v).css( 'width' , p1.sum_outer_width( true ) )
    return