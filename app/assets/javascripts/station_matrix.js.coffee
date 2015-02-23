processStationMatrixes = ( selector_for_station_matrixes , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border ) ->
  # 各路線の要素 (.railway_line) の要素の集合
  railway_line_domains = $( selector_for_station_matrixes ).children()
  width_of_main_content_center = $( '#main_content_center' ).innerWidth()
  width_of_railway_line_matrix_small = width_of_each_normal_railway_line # Math.floor( width_of_each_normal_railway_line * 1.0 / goldenRatio )
  base_width_of_stations = width_of_main_content_center - ( width_of_railway_line_matrix_small + width_of_border * 2 )  - width_of_border

  railway_line_domains.each ->
    #---------------- 各路線について

    railway_line_domain = $( this )
    railway_line_matrix_small = railway_line_domain.children( '.railway_line_matrix_small' ).first()

    #-------- railway_line_matrix_small , domain_of_stations_in_station_matrix それぞれの長さを設定し、railway_line_domain の長さも微調整する
    
    changeWidth( railway_line_domain , width_of_main_content_center )
    changeWidth( railway_line_matrix_small , width_of_railway_line_matrix_small )

    has_branch_info = hasBranchLineInfo( railway_line_domain )

    # 一般路線の場合
    unless has_branch_info
      domain_of_stations = railway_line_domain.children( '.stations' )
      changeWidthOfDomainOfStations( domain_of_stations , base_width_of_stations )
      
    # 支線がある場合
    else
      domains_of_stations = railway_line_domain.children( '.stations_on_main_line , .stations_on_branch_line' )
      domains_of_stations.each ->
        changeWidthOfDomainOfStations( $( this ) , base_width_of_stations )
        return

    #-------- railway_line_matrix_small 内部の要素を操作する
    
    info_domain_in_railway_line_matrix_small = railway_line_matrix_small.children( '.info' ).first()
    processElementsInRailwayLineInfoInRailwayLineMatrixSmall( info_domain_in_railway_line_matrix_small )

    #-------- railway_line_matrix_small , domain_of_stations_in_station_matrix , railway_line_domain それぞれの高さを揃える
    
    # 一般路線の場合
    unless has_branch_info
      height_of_contents = Math.max( railway_line_matrix_small.outerHeight( true ) , domain_of_stations.outerHeight( true ) )
      railway_line_domain.css( 'height' , height_of_contents )
      railway_line_matrix_small.css( 'height' , height_of_contents - width_of_border * 2 )

      height_of_stations = height_of_contents - width_of_border * 2 - ( domain_of_stations.innerHeight() - domain_of_stations.height() )
      domain_of_stations.css( 'height' , height_of_stations )
    
    else
      domains_of_stations = railway_line_domain.children( '.stations_on_main_line , .stations_on_branch_line' )
      sum_height_of_domains = getSumInnerHeight( domains_of_stations , true )
      if railway_line_matrix_small.outerHeight( true ) < sum_height_of_domains
        railway_line_matrix_small.css( 'height' , sum_height_of_domains )
      else
        alert( 'Error' )

    #-------- info 領域の上下の margin を変更
    
    margin_of_info = ( railway_line_matrix_small.innerHeight() - info_domain_in_railway_line_matrix_small.outerHeight() ) * 0.5
    info_domain_in_railway_line_matrix_small.css( 'margin-top' , margin_of_info ).css( 'margin-bottom' , margin_of_info )
    return
  return
  
window.processStationMatrixes = processStationMatrixes

#-------- 路線情報（左側の領域）に含まれる要素の操作

processElementsInRailwayLineInfoInRailwayLineMatrixSmall = ( info ) ->
  railway_line_code_outer = info.children( '.railway_line_code_outer' ).first()
  text = info.children( '.text' ).first()

  info_height = Math.max( railway_line_code_outer.outerHeight( true ) , text.outerHeight( true ) )
  margin_of_railway_line_code_outer = ( info_height - railway_line_code_outer.outerHeight() ) * 0.5
  margin_of_text = ( info_height - text.outerHeight() ) * 0.5

  # info 領域の高さを設定し、railway_line_code_outer と text の上下方向の位置を中心揃えにする
  
  railway_line_code_outer.css( 'margin-top' , margin_of_railway_line_code_outer ).css( 'margin-bottom' , margin_of_railway_line_code_outer )
  text.css( 'margin-top' , margin_of_text ).css( 'margin-bottom' , margin_of_text )
  info.css( 'height' , info_height )
  return

#-------- 支線の有無の判定

hasBranchLineInfo = ( railway_line_domain ) ->
  domain_of_stations = railway_line_domain.children( )
  if domain_of_stations.length == 3
    return true
  else
    if domain_of_stations.length == 2
      return false
    else
      alert( 'Error' )
      return

#-------- 駅名領域（右側）の操作

changeWidthOfDomainOfStations = ( domain_of_stations , base_width_of_stations ) ->
  width_of_stations_of_this_railway_line = base_width_of_stations - ( domain_of_stations.innerWidth() - domain_of_stations.width() )
  changeWidth( domain_of_stations , width_of_stations_of_this_railway_line )
  return