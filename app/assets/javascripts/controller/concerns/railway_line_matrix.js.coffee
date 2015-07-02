# 路線記号の操作
class RailwayLineMatrixes

  constructor: ( @domain = $( "#railway_line_matrixes" ) ) ->

  # 路線の box の要素の集合
  railway_line_boxes = (v) ->
    return v.domain.children()

  # 路線の box の要素の数
  number_of_railway_line_groups = (v) ->
    return railway_line_boxes(v).length

  # 一般路線の数
  number_of_normal_railway_lines = (v) ->
    p = new RailwayLineAndStationMatrix()
    return p.number_of_normal_railway_lines

  # 1行に表示する路線数
  number_of_railway_lines_in_each_row = (v) ->
    p = new RailwayLineAndStationMatrix()
    return p.number_of_railway_lines_in_each_row

  # 特殊路線（「有楽町線・副都心線」など）の数
  number_of_special_railway_line_groups = (v) ->
    return number_of_railway_line_groups(v) - number_of_normal_railway_lines(v)

  # 一般路線の集合
  normal_railway_lines = (v) ->
    return railway_line_boxes(v).slice( 0 , number_of_normal_railway_lines(v) )

  # 特殊路線の集合
  special_railway_lines = (v) ->
    return railway_line_boxes(v).slice( number_of_normal_railway_lines(v) )

  # 一般路線の box の高さ (outerHeight)
  outer_height_of_each_railway_line_box = (v) ->
    return normal_railway_lines(v).first().outerHeight()

  # 全体の行の数
  number_of_all_railway_lines = (v) ->
    p = new RailwayLineAndStationMatrix()
    rows_of_normal_railway_lines = p.number_of_rows_of_normal_railway_lines_in_railway_line_matrix()
    return rows_of_normal_railway_lines + number_of_special_railway_line_groups(v)

  # 全体の高さ
  height_of_domain = (v) ->
    p = new RailwayLineAndStationMatrix()
    _border_width = p.border_width
    return number_of_all_railway_lines(v) * ( outer_height_of_each_railway_line_box(v) - _border_width ) + _border_width

  # 一般路線の box の設定
  process_normal_railway_lines = (v) ->
    p = new RailwayLineAndStationMatrix()
    w = p.width_of_each_normal_railway_line()
    normal_railway_lines(v).each ->
      normal_railway_line_box = new NormalRailwayLineBox( $( this ) , w )
      normal_railway_line_box.process()
      return
    return

  # 特殊な路線の box の設定
  process_special_railway_lines = (v) ->
    p = new RailwayLineAndStationMatrix()
    _width = p.width_of_each_special_railway_line_group()
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
    p = new RailwayLineAndStationMatrix()
    new_width = p.new_width_to_main_content_center()
    main_content_center = $( 'div#main_content_center' )
    main_content_center.css( 'width' , new_width )
    return

  process: ->
    # console.log 'RailwayLineMatrixes\#process \(' + @domain.length + '\)'

    # if @domain.length > 0
    process_normal_railway_lines(@)
    process_special_railway_lines(@)
    set_height_of_domain(@)

    set_new_width_to_main_content_center(@)
    return

window.RailwayLineMatrixes = RailwayLineMatrixes