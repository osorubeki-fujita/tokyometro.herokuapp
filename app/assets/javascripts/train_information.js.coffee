class Traininformations
  constructor: ( @width_of_each_normal_railway_line , @domain = $( "#train_informations" ) ) ->

  informations = (v) ->
    return v.domain.children()

  size_of_status = (v) ->
    width_of_railway_line_matrix = 0
    height_of_railway_line_matrix = 0
    informations(v).each ->
      width_of_railway_line_matrix = Math.max( width_of_railway_line_matrix , $( this ).children().eq(0).outerWidth( true ) )
      height_of_railway_line_matrix = Math.max( height_of_railway_line_matrix , $( this ).children().eq(0).innerHeight() )
      return
    width_of_status = v.domain.innerWidth() - width_of_railway_line_matrix - 2
    height_of_status = height_of_railway_line_matrix
    return { width: width_of_status , height: height_of_status }

  process: ->
    _size_of_status = size_of_status(@)

    informations(@).each ->
      train_information = new TrainInformation( $( this ) , @width_of_each_normal_railway_line , _size_of_status )
      train_infomation.process_railway_line_matrix()

    informations(@).each ->
      train_infomation = new TrainInformation( $( this ) , @width_of_each_normal_railway_line , _size_of_status )
      train_infomation.set_size()
      return
    return

window.Traininformations = Traininformations

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

  info = (v) ->
    return v.domain.children().first()

  railway_line_code_outer = (v) ->
    return info(v).children().eq(0)

  text = (v) ->
    return info(v).children().eq(1)

  info_padding_top_and_bottom = (v) ->
    return 4

  new_height_of_info = (v) ->
    return Math.max( railway_line_code_outer(v).outerHeight( true ) , text(v).outerHeight( true ) ) + info_padding_top_and_bottom(v) * 2

  change_attributes = (v) ->
    _h = new_height_of_info(v)
    _padding = info_padding_top_and_bottom(v)

    info(v).css( 'height' , _h )
    v.domain.css( 'height' , _h ).css( 'padding-top' , _padding ).css( 'padding-bottom' , _padding ).css( 'width' , v.width_of_each_normal_railway_line )

    w = Math.ceil( railway_line_code_outer(v).outerWidth( true ) + text(v).outerWidth( true ) )
    info(v).css( 'width' , w )
    return

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