class StationMatrixes

  constructor: ( @domain = $( "#station_matrixes" ) ) ->

  domains_of_each_railway_line = (v) ->
    return v.domain.children()

  process: ->
    p = new RailwayLineAndStationMatrix()
    width_of_main_content_center = p.width_of_main_content_center
    width_of_each_normal_railway_line = p.width_of_each_normal_railway_line()
    border_width = p.border_width

    domains_of_each_railway_line(@).each ->
      station_matrix_row = new StationMatrixRow( $(@) , width_of_main_content_center , width_of_each_normal_railway_line , border_width )
      station_matrix_row.process()
      return
    return

window.StationMatrixes = StationMatrixes

class StationMatrixRow

  constructor: ( @domain , @width_of_main_content_center , @width_of_each_normal_railway_line , @border_width ) ->

  width_of_railway_line_matrix_small = (v) ->
    return v.width_of_each_normal_railway_line
    # Math.floor( @width_of_each_normal_railway_line * 1.0 / goldenRatio )

  base_width_of_station_box = (v) ->
    return v.width_of_main_content_center - ( width_of_railway_line_matrix_small(v) + v.border_width * 2 ) - v.border_width

  domains_in_a_row = (v) ->
    return v.domain.children()

  has_branch_line = (v) ->
    switch domains_in_a_row(v).length
      when (2+1)
        return true
      when (1+1)
        return false
      else
        # console.log 'StationMatrixRow\#has_branch ... Error'
        alert( 'Error' )
        return false
    return

  railway_line_matrix_small = (v) ->
    return v.domain.children( '.railway_line_matrix_small' ).first()

  info_domain_in_railway_line_matrix_small = (v) ->
    return railway_line_matrix_small(v).children( '.info' ).first()

  # change_width = (v) ->
    # return

  change_width_of_domain = (v) ->
    v.domain.css( 'width' , v.width_of_main_content_center )
    return

  change_width_of_railway_line_matrix_small = (v) ->
    _width = width_of_railway_line_matrix_small(v)
    # console.log 'StationMatrixRow\#change_width_of_railway_line_matrix_small' + ' ' + '\(width: ' + _width + ')'
    railway_line_matrix_small(v).css( 'width' , _width )
    return

  domains_of_stations_of_railway_line_including_branch_line = (v) ->
    return v.domain.children( 'ul.stations_on_main_line , ul.stations_on_branch_line' )

  ul_domain_of_stations_of_normal_railway_line = (v) ->
    return v.domain.children( 'ul.stations' ).first()

  process: ->
    # console.log( 'StationMatrixRow\#process' )

    #-------- railway_line_matrix_small , domain_of_stations_in_station_matrix それぞれの長さを設定し、railway_line_domain の長さも微調整する
    change_width_of_domain(@)
    change_width_of_railway_line_matrix_small(@)
    change_width_of_station_domain(@)

    process_elements_in_railway_line_info_in_railway_line_matrix_small(@)

    # 支線がある場合
    if has_branch_line(@)
      set_height_of_station_domains_of_railway_line_including_branch_line(@)
    # 一般路線の場合
    else
      # set_height_of_domain_of_normal_railway_line(@)
      set_height_of_domain_of_normal_railway_line_matrix_small(@)
      set_height_of_station_domain_of_normal_railway_line(@)

    set_margin_of_info_domain_in_railway_line_matrix_small(@)
    return

  change_width_of_station_domain = (v) ->
    # console.log 'StationMatrixRow\#change_width_of_station_domain'

    # 支線がある場合
    if has_branch_line(v)
      domains_of_stations_of_railway_line_including_branch_line(v).each ->
        station_group = new StationGroup( $(@) , base_width_of_station_box(v) )
        station_group.process()
        return
    # 一般路線の場合
    else
      station_group = new StationGroup( ul_domain_of_stations_of_normal_railway_line(v) , base_width_of_station_box(v) )
      station_group.process()
    return

  #-------- 路線情報（左側の領域 railway_line_matrix_small）内部の要素の操作
  process_elements_in_railway_line_info_in_railway_line_matrix_small = (v) ->
    # console.log 'StationMatrixRow\#process_elements_in_railway_line_info_in_railway_line_matrix_small'
    # console.log info_domain_in_railway_line_matrix_small(v).attr( 'class' )
    matrix = new RailwayLineMatrixSmallInfo( info_domain_in_railway_line_matrix_small(v) )
    matrix.set_vertical_align_center()
    return

  sum_height_of_station_domains_of_railway_line_including_branch_line = (v) ->
    # console.log 'StationMatrixRow\#sum_height_of_station_domains_of_railway_line_including_branch_line'
    p = new DomainsCommonProcessor( domains_of_stations_of_railway_line_including_branch_line(v) )
    return p.sum_inner_height()

  set_height_of_station_domains_of_railway_line_including_branch_line = (v) ->
    # console.log 'StationMatrixRow\#set_height_of_station_domains_of_railway_line_including_branch_line'
    _railway_line_matrix_small = railway_line_matrix_small(v)
    sum_height = sum_height_of_station_domains_of_railway_line_including_branch_line(v)
    if _railway_line_matrix_small.outerHeight( true ) < sum_height
      _railway_line_matrix_small.css( 'height' , sum_height )
    else
      # console.log 'Error: StationMatrixRow\#set_height_of_station_domains_of_railway_line_including_branch_line'
      alert( 'Error' )
    return

  new_height_of_domain_of_normal_railway_line = (v) ->
    h = Math.max( railway_line_matrix_small(v).outerHeight( true ) , ul_domain_of_stations_of_normal_railway_line(v).outerHeight( true ) )
    # console.log 'StationMatrixRow\#new_height_of_domain_of_normal_railway_line' + ' ' + '(height:' + h + ')'
    return h

  # set_height_of_domain_of_normal_railway_line = (v) ->
    # return v.domain.css( 'height' , new_height_of_domain_of_normal_railway_line(v) )

  new_height_of_railway_line_matrix_small_of_normal_railway_line = (v) ->
    h = new_height_of_domain_of_normal_railway_line(v) - v.border_width
    # console.log 'StationMatrixRow\#new_height_of_railway_line_matrix_small_of_normal_railway_line' + ' ' + '(height:' + h + ')'
    return h

  set_height_of_domain_of_normal_railway_line_matrix_small = (v) ->
    railway_line_matrix_small(v).css( 'height' , new_height_of_railway_line_matrix_small_of_normal_railway_line(v) )
    return

  padding_top_plus_bottom_of_domain_of_stations_of_normal_railway_line = (v) ->
    d = ul_domain_of_stations_of_normal_railway_line(v)
    return d.innerHeight() - d.height()

  height_of_domain_of_stations_of_normal_railway_line = (v) ->
    return new_height_of_domain_of_normal_railway_line(v) - ( v.border_width + padding_top_plus_bottom_of_domain_of_stations_of_normal_railway_line(v) )

  set_height_of_station_domain_of_normal_railway_line = (v) ->
    # console.log( 'StationMatrixRow\#set_height_of_station_domain_of_normal_railway_line' )
    ul_domain_of_stations_of_normal_railway_line(v).css( 'height' , height_of_domain_of_stations_of_normal_railway_line(v) )
    return

  # info 領域の上下の margin を変更
  set_margin_of_info_domain_in_railway_line_matrix_small = (v) ->
    matrix = new RailwayLineMatrixSmallInfo( info_domain_in_railway_line_matrix_small(v) )
    matrix.set_margin_top_and_bottom( railway_line_matrix_small(v).innerHeight() )
    return

# 駅名領域（右側）
class StationGroup

  constructor: ( @domain , @base_width_of_station_box ) ->

  width_of_domain = (v) ->
    return v.base_width_of_station_box - ( v.domain.innerWidth() - v.domain.width() )

  li_stations = (v) ->
    return v.domain.children( 'li.station' )

  process: ->
    set_width_of_domain(@)
    set_tooltips_to_li_stations(@)
    return

  set_width_of_domain = (v) ->
    v.domain.css( 'width' , width_of_domain(v) )
    return

  set_tooltips_to_li_stations = (v) ->
    p = new TooltipsOnLinksToStation( li_stations(v).children( 'a' ) )
    p.set()
    return
