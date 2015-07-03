class RailwayLineAndStationMatrix

  constructor: ->
    # box の border の幅
    @border_width = 1
    # 中央の div#main_content_center の幅 (width)
    @width_of_main_content_center = $( 'div#main_content_center' ).width()
    # 一般路線の数
    @number_of_normal_railway_lines = 9
    # 1行に表示する路線数
    @number_of_railway_lines_in_each_row = 3

  # 一般路線の幅
  width_of_each_normal_railway_line: ->
    base = ( @width_of_main_content_center - ( @number_of_railway_lines_in_each_row + 1 ) * @border_width ) * 1.0 / @number_of_railway_lines_in_each_row
    return Math.floor( base )

  # 特殊路線の幅
  width_of_each_special_railway_line_group: ->
    return @.width_of_each_normal_railway_line() * @number_of_railway_lines_in_each_row + ( ( @number_of_railway_lines_in_each_row - 1 ) * @border_width )

  new_width_to_main_content_center: ->
    return @.width_of_each_special_railway_line_group() + @border_width * 2

  # 一般路線の行の数
  number_of_rows_of_normal_railway_lines_in_railway_line_matrix: ->
    err = 0.01 # 誤差対策
    base = @number_of_normal_railway_lines * 1.0 / @number_of_railway_lines_in_each_row - err
    return Math.ceil( base )

window.RailwayLineAndStationMatrix = RailwayLineAndStationMatrix
