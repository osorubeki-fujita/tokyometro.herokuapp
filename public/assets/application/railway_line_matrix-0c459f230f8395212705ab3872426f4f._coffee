class TrainInformation
  constructor: ( @domain , @width_of_each_normal_railway_line , @size ) ->

  railway_line_matrix = (v) ->
    return v.domain.children().eq(0)

  status = (v) ->
    return v.domain.children().eq(1)

  set_size: ->
    status(@).css( 'width' , @size.width ).css( 'height' , @size.height )
    return

  process_railway_line_matrix: ->
    _railway_line_matrix = new TrainInformationRailwayLineMatrix( railway_lline_matrix(@) , @width_of_each_normal_railway_line )
    _railway_line_matrix.process()
    return

class TrainInformationRailwayLineMatrix
  constructor: ( @domain , @width_of_each_normal_railway_line ) ->

  change_attributes = (v) ->


  width_of_info_domain = (v) ->
    return info(v).outerWidth( true )

  new_margin_left_and_right_of_info_domain = (v) ->
    return Math.floor( ( v.width_of_each_normal_railway_line - width_of_info_domain ) * 0.5 )

  change_width_and_margin_of_info_domain = (v) ->
    _margin = new_margin_left_and_right_of_info_domain(v)
    info(v).css( 'margin-left' , _margin ).css( 'margin-right' , _margin )
    return

  process: ->
    change_attributes(@)
    change_width_and_margin_of_info_domain(@)
    return