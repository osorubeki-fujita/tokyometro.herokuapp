# 路線記号の操作
class RailwayLineMatrixes

  constructor: ( @domain = $( "#railway_line_matrixes" ) ) ->

  # 1行に表示する路線数
  number_of_railway_lines_in_each_row = (v) ->
    return 3

  # box の border の幅
  border_width = (v) ->
    return 1

  # 路線の box の要素の集合
  railway_line_boxes = (v) ->
    return v.domain.children()

  # 一般路線の数
  number_of_normal_railway_lines = (v) ->
    return 9

  # 一般路線の集合
  normal_railway_lines = (v) ->
    return railway_line_boxes(v).slice( 0 , number_of_normal_railway_lines(v) )

  # 特殊路線（「有楽町線・副都心線」など）の数
  number_of_special_railway_line_groups = (v) ->
    return railway_line_boxes(v).size() - number_of_normal_railway_lines(v)

  # 特殊路線の集合
  special_railway_lines = (v) ->
    return railway_line_boxes(v).slice( number_of_normal_railway_lines(v) )

  # 一般路線の box の高さ (outerHeight)
  outer_height_of_each_railway_line_box = (v) ->
    return normal_railway_lines(v).first().outerHeight()

  # 中央の div#main_content_center の幅 (innerWidth)
  width_of_main_content_center = (v) ->
    return $( 'div#main_content_center' ).innerWidth()

  # 一般路線の幅
  width_of_each_normal_railway_line = (v) ->
    _in_each_row = number_of_railway_lines_in_each_row(v)
    base = ( width_of_main_content_center(v) - ( _in_each_row + 1 ) * border_width(v) ) * 1.0 / _in_each_row
    return Math.floor( base )

  # 特殊路線の幅
  width_of_each_special_railway_line_group = (v) ->
    _in_each_row = number_of_railway_lines_in_each_row(v)
    return width_of_each_normal_railway_line(v) * _in_each_row + ( ( _in_each_row - 1 ) * border_width(v) )

  # 一般路線の行の数
  number_of_rows_of_normal_railway_lines = (v) ->
    err = 0.01 # 誤差対策
    base = number_of_normal_railway_lines(v) * 1.0 / number_of_railway_lines_in_each_row - err
    return Math.ceil( base )

  # 全体の行の数
  number_of_all_railway_lines = (v) ->
    return number_of_rows_of_normal_railway_lines(v) + number_of_special_railway_line_groups(v)

  # 全体の高さ
  height_of_domain = (v) ->
    _border_width = border_width(v)
    return number_of_all_railway_lines(v) * ( outer_height_of_each_railway_line_box(v) - _border_width ) + _border_width

  # 一般路線の box の設定
  process_normal_railway_lines = (v) ->
    _width = width_of_each_normal_railway_line(v)
    normal_railway_lines(v).each ->
      # console.log $( this )
      # console.log $( this ).children( '.info' )
      # console.log $( this ).children( '.info' ).first()
      normal_railway_line_box = new NormalRailwayLineBox( $( this ) , _width )
      normal_railway_line_box.process()
      return
    return

  # 特殊な路線の box の設定
  process_special_railway_lines = (v) ->
    _width = width_of_each_special_railway_line_group(v)
    special_railway_lines(v).each ->
      # console.log $( this )
      # console.log $( this ).children( '.info' )
      # console.log $( this ).children( '.info' ).first()
      special_railway_line_box = new SpecialRailwayLineBox( $( this ) , _width )
      special_railway_line_box.process()
      return
    return

  # 全体の高さの設定
  set_height_of_domain = (v) ->
    v.domain.css( 'height' , height_of_domain(v) )
    return

  set_new_width_to_main_content_center = (v) ->
    main_content_center = $( 'div#main_content_center' )
    new_width = width_of_each_special_railway_line_group(v) + border_width(v) * 2
    main_content_center.css( 'width' , new_width )
    return

  process_station_matrixes = (v) ->

    railway_line_domains = $( "#station_matrixes" ).children()

    _width_of_main_content_center = width_of_main_content_center(v)
    _width_of_each_normal_railway_line = width_of_each_normal_railway_line(v)
    _border_width = border_width(v)

    railway_line_domains.each ->
      railway_line_domain = $( this )
      # console.log 'RailwayLineMatrixes\#process_station_matrixes' + ' ' + railway_line_domain.attr( 'class' )
      station_matrix_row = new StationMatrixRow( railway_line_domain , _width_of_main_content_center , _width_of_each_normal_railway_line , _border_width )
      station_matrix_row.process()
      return

    # train_informations = new Traininformations( _width_of_each_normal_railway_line )
    # train_informations.process()
    return

  process: ->
    # console.log 'RailwayLineMatrixes\#process \(' + @domain.length + '\)'

    # if @domain.length > 0
    process_normal_railway_lines(@)
    process_special_railway_lines(@)
    set_height_of_domain(@)

    set_new_width_to_main_content_center(@)
    process_station_matrixes(@)
    #return
    return

window.RailwayLineMatrixes = RailwayLineMatrixes