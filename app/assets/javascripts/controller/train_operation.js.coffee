class TrainOperationInfos

  constructor: ( @domain = $( "#train_operation_infos" ) ) ->
  
  has_train_operation_info_title = (v) ->
    return train_operation_info_title(v).length > 0
  
  has_title_of_links_to_station_info_pages = (v) ->
    return title_of_links_to_station_info_pages(v).length > 0

  # 運行情報がページ内に存在するか否かの判定
  has_informations = (v) ->
    return informations(v).length > 0

  has_titles = (v) ->
    return titles(v).length > 0
  
  on_train_operation_controller = (v) ->
    return has_train_operation_info_title(v)
  
  train_operation_info_title = (v) ->
    return $( '#train_operation_info_title' )
  
  title_of_links_to_station_info_pages = (v) ->
    return $( '#links_to_station_info_pages' )
      .children( '.content_header' )

  informations = (v) ->
    return v.domain.children( '.train_operation_info , .train_operation_info_test' )

  informations_including_precise_version = (v) ->
    return v.domain.children( '.train_operation_info , .train_operation_info_precise_version , .train_operation_info_test' )

  titles = (v) ->
    return v.domain.find( '.title_of_train_operation_infos , .title_of_train_location_infos' )

  informations_of_precise_version = (v) ->
    return v.domain.children( '.train_operation_info_precise_version' )

  width_of_railway_line_matrix = (v) ->
    w = 0
    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      w = Math.max( w , train_operation_info.railway_line_matrix_outer_width( true ) )
      return
    return w

  height_of_railway_line_matrix = (v) ->
    h = 0
    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      h = Math.max( h , train_operation_info.railway_line_matrix_inner_height() )
      return
    return h

  width_of_status = (v) ->
    return v.domain.innerWidth() - width_of_railway_line_matrix(v) - 3

  height_of_status = (v) ->
    h = 0
    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      w = Math.max( w , train_operation_info.status_inner_height() )
      return
    return h

  height_of_railway_line_matrix_and_status = (v) ->
    h = Math.max( height_of_railway_line_matrix(v) , height_of_status(v) )
    # console.log 'TrainOperationInfos\#height_of_railway_line_matrix_and_status: '
    # console.log h
    return h

  size_of_railway_line_matrix = (v,h) ->
    h = { width: width_of_railway_line_matrix(v) , height: h }
    # console.log 'TrainOperationInfos\#size_of_railway_line_matrix: '
    # console.log h
    return h

  size_of_status = (v,h) ->
    h = { width: width_of_status(v) , height: h }
    # console.log 'TrainOperationInfos\#size_of_status: '
    # console.log h
    return h

  process: ->
    if on_train_operation_controller(@) and has_title_of_links_to_station_info_pages(@)
      process_title_of_links_to_station_info_pages(@)
    if has_titles(@)
      process_titles(@)
    # 運行情報がページ内に存在する場合
    if has_informations(@)
      # それぞれの路線名のテキスト領域の大きさを初期化
      initialize_railway_line_matrix_text_size(@)
      # それぞれの運行状況ステータスのテキスト領域の大きさを初期化
      initialize_status_text_size(@)
      # それぞれの路線名・運行状況ステータスの領域の大きさを初期化
      initialize_size_of_railway_line_matrix_and_status(@)
      set_attributes(@)
    return
  
  process_title_of_links_to_station_info_pages = (v) ->
    p = new ContentHeaderProcessor( title_of_links_to_station_info_pages(v) )
    p.process()
    return

  process_titles = (v) ->
    p = new ContentHeaderProcessor( titles(v) )
    p.process()
    return

  # それぞれの路線名のテキスト領域の大きさを初期化するメソッド
  initialize_railway_line_matrix_text_size = (v) ->
    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      train_operation_info.initialize_railway_line_matrix_text_size()
      return
    return

  max_width_of_status_text = (v) ->
    w = 0
    informations(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      p = new DomainsCommonProcessor( train_operation_info.status().text().children() )
      outer_width = p.max_outer_width( true )
      w = Math.max( w , Math.ceil( outer_width ) )
      return
    return Math.ceil( w * 0.5 + 1 ) * 2

  # それぞれの運行状況ステータスのテキスト領域の大きさを初期化するメソッド
  initialize_status_text_size = (v) ->
    _max_width_of_status_text = max_width_of_status_text(v)
    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      train_operation_info.initialize_status_text_size( _max_width_of_status_text )
      return
    return

  # それぞれの路線名・運行状況ステータスの領域の大きさを初期化するメソッド
  initialize_size_of_railway_line_matrix_and_status = (v) ->
    h = height_of_railway_line_matrix_and_status(v)
    _size_of_railway_line_matrix = size_of_railway_line_matrix(v,h)
    _size_of_status = size_of_status(v,h)

    informations_including_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      train_operation_info.initialize_size( _size_of_railway_line_matrix , _size_of_status )
      return
    return

  set_attributes = (v) ->
    informations(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      train_operation_info.set_attributes()
      return
    informations_of_precise_version(v).each ->
      train_operation_info = new TrainOperationInfo( $(@) )
      train_operation_info.set_attributes( true )
      return
    return

window.TrainOperationInfos = TrainOperationInfos

class TrainOperationInfo
  constructor: ( @domain ) ->

  railway_line_matrix: ->
    r = new TrainOperationInfoRailwayLineMatrix( @domain.children( '.railway_line_matrix_small' ).first() )
    return r

  status: ->
    # console.log 'TrainOperationInfo\#status'
    s = new TrainOperationInfoStatus( @domain.children( '.status' ).first() )
    return s

  railway_line_matrix_outer_width: ( b = false ) ->
    return @.railway_line_matrix().outer_width(b)

  railway_line_matrix_inner_height: ->
    return @.railway_line_matrix().inner_height()

  status_inner_height: ->
    return @.status().inner_height()

  # 個別の路線名のテキスト領域の大きさを初期化するメソッド
  initialize_railway_line_matrix_text_size: ->
    @.railway_line_matrix().initialize_text_size()
    return

  # 個別の運行状況ステータスのテキスト領域の大きさを初期化するメソッド
  initialize_status_text_size: ( _width ) ->
    @.status().initialize_text_size( _width )

  # それぞれの路線名・運行状況ステータスの領域の大きさを初期化するメソッド
  initialize_size: ( size_of_railway_line_matrix , size_of_status ) ->
    initialize_size_of_railway_line_matrix( @ , size_of_railway_line_matrix )
    initialize_size_of_status( @ , size_of_status )
    return

  # それぞれの路線名の領域の大きさを初期化するメソッド
  initialize_size_of_railway_line_matrix = ( v , size_of_railway_line_matrix ) ->
    v.railway_line_matrix().initialize_size( size_of_railway_line_matrix )
    return

  initialize_size_of_status = ( v , size_of_status ) ->
    # console.log 'TrainOperationInfo\#initialize_size_of_status'
    _status = v.status()
    # console.log _status
    _status.initialize_size( size_of_status )
    return

  set_attributes: ( precise_version = false ) ->
    set_attributes_of_railway_line_matrix(@)
    set_attributes_of_status( @ , precise_version )
    set_height_of_railway_line_matrix_and_status_and_set_margin(@)
    return

  set_attributes_of_railway_line_matrix = (v) ->
    v.railway_line_matrix().set_attributes()
    return

  set_attributes_of_status = ( v , precise_version ) ->
    v.status().set_attributes( precise_version )
    return

  domain_height_new = (v) ->
    # console.log 'TrainOperationInfo\#domain_height_new'
    _railway_line_matrix = v.railway_line_matrix().domain
    border = ( _railway_line_matrix.outerHeight( false ) - _railway_line_matrix.innerHeight() ) * 0.5
    _h = _railway_line_matrix.innerHeight() + border
    # console.log _h
    return _h

  arrange_height_of_railway_line_matrix_and_status = ( v , _max_outer_height ) ->
    # console.log 'TrainOperationInfo\#arrange_height_of_railway_line_matrix_and_status'
    v.railway_line_matrix().domain.css( 'height' , _max_outer_height )
    v.status().domain.css( 'height' , _max_outer_height )
    return

  set_height_of_domain = (v) ->
    # console.log 'TrainOperationInfo\#set_height_of_domain'
    v.domain.css( 'height' , domain_height_new(v) )
    return

  max_outer_height_of_railway_line_matrix_and_status = (v) ->
    railway_line_matrix_outer_height = v.railway_line_matrix().domain.outerHeight( false )
    status_outer_height = v.status().domain.outerHeight( false )
    return Math.ceil( Math.max( railway_line_matrix_outer_height , status_outer_height ) )

  set_height_of_railway_line_matrix_and_status = (v) ->
    # console.log 'TrainOperationInfo\#set_height_of_railway_line_matrix_and_status'
    _max_outer_height = max_outer_height_of_railway_line_matrix_and_status(v)
    arrange_height_of_railway_line_matrix_and_status( v , _max_outer_height )
    set_height_of_domain(v)
    return

  set_height_of_railway_line_matrix_and_status_and_set_margin = (v) ->
    # console.log 'TrainOperationInfo\#set_height_of_railway_line_matrix_and_status_and_set_margin \#1'
    _max_outer_height = max_outer_height_of_railway_line_matrix_and_status(v)
    arrange_height_of_railway_line_matrix_and_status( v , _max_outer_height )
    #
    # console.log 'TrainOperationInfo\#set_height_of_railway_line_matrix_and_status_and_set_margin \#2'
    #
    status_outer_height = v.status().infos().outerHeight()
    if status_outer_height < _max_outer_height
      margin_top_and_bottom_of_status_info = ( _max_outer_height - status_outer_height ) * 0.5
      # console.log status_outer_height
      # console.log max_outer_height
      # console.log margin_top_and_bottom_of_status_info
      v.status().infos().css( 'margin-top' , margin_top_and_bottom_of_status_info )
      v.status().infos().css( 'margin-bottom' , margin_top_and_bottom_of_status_info )
    #
    # console.log 'TrainOperationInfo\#set_height_of_railway_line_matrix_and_status_and_set_margin \#3'
    set_height_of_domain(v)
    return

class TrainOperationInfoMatrixBase

  constructor: ( @domain ) ->

  outer_width: ( b = false ) ->
    return Math.ceil( @domain.outerWidth(b) )

  inner_height: ->
    return Math.ceil( @domain.innerHeight() )

  # 領域の大きさを変更するメソッド
  set_size: ( size ) ->
    @domain.css( 'width' , size.width ).css( 'height' , size.height )
    return

  # 領域の大きさを初期化するメソッド
  initialize_size: ( size ) ->
    @.set_size( size )
    return

class TrainOperationInfoRailwayLineMatrix extends TrainOperationInfoMatrixBase

  set_attributes: ->
    set_height_to_railway_line_matrix(@)
    set_width_to_info(@)
    set_vertical_align_center(@)
    return

  info: ->
    # console.log 'RailwayLineMatrixSmallBase\#info'
    _info = new RailwayLineMatrixSmallInfo( @domain.children( '.info' ).first() )
    return _info

  set_height_to_railway_line_matrix = (v) ->
    _info_margin_top_and_bottom = info_margin_top_and_bottom(v)
    _h = v.info().max_height_of_railway_line_code_outer_and_text() + _info_margin_top_and_bottom * 2

    v.domain.css( 'height' , _h )
    $.each [ 'margin-top' , 'margin-bottom' ] , ( i , attr ) ->
      v.info().domain.css( attr , _info_margin_top_and_bottom )
      return
    return

  set_width_to_info = (v) ->
    v.info().domain.css( 'width' , v.info().sum_outer_width_of_railway_line_code_outer_and_text() )
    return

  set_vertical_align_center = (v) ->
    v.info().set_vertical_align_center()
    return

  info_margin_top_and_bottom = (v) ->
    return 8

  # 個別のテキスト領域の大きさを初期化するメソッド
  initialize_text_size: ->
    @.info().initialize_text_size()
    return

class TrainOperationInfoStatus extends TrainOperationInfoMatrixBase

  infos: ->
    return @domain.children( '.infos' )

  icon: ->
    return @.infos().children( '.icon' ).first()

  icon_body: ->
    return @.icon().children().first()

  text: ->
    return @.infos().children( '.text' ).first()

  additional_infos = (v) ->
    return v.infos().children( '.additional_infos' ).first()

  # 個別の運行状況ステータスのテキスト領域の大きさを初期化するメソッド
  initialize_text_size: ( _width ) ->
    @.text().css( 'width' , _width )
    p = new DomainsCommonProcessor( @.text().children() )
    @.text().css( 'height' , p.sum_outer_height( true ) )
    return

  max_height_of_icon_and_text = (v) ->
    p = new DomainsCommonProcessor( $( [ v.icon() , v.text() ] ) )
    return p.max_outer_height( true )

  max_height_of_children = (v) ->
    p = new DomainsCommonProcessor( v.infos().children() )
    return p.max_outer_height( true )

  set_attributes: ( precise_version = false ) ->
    set_width_of_additional_infos(@)
    set_margin_top_of_icon_and_text(@)
    unless precise_version
      set_margin_bottom_of_children(@)
    set_height_of_infos(@,precise_version)
    set_height_of_domain(@)
    return

  width_of_additional_infos = (v) ->
    p = new DomainsCommonProcessor( $( [ v.icon() , v.text() ] ) )
    return v.infos().width() - p.sum_outer_width( true )

  set_width_of_additional_infos = (v) ->
    additional_infos(v).css( 'width' , width_of_additional_infos(v) )
    return

  set_margin_top_of_icon_and_text = (v) ->
    _max_height_of_icon_and_text = max_height_of_icon_and_text(v)
    $( [ v.icon() , v.text() ] ).each ->
      _margin_top = ( _max_height_of_icon_and_text - $(@).outerHeight( true ) ) * 0.5
      $(@).css( 'margin-top' , _margin_top )
      return
    return

  set_margin_bottom_of_children = (v) ->
    _max_height_of_children = max_height_of_children(v)
    v.infos().children().each ->
      _margin_bottom = ( _max_height_of_children - $(@).outerHeight( true ) )
      $(@).css( 'margin-bottom' , _margin_bottom )
      return
    return

  set_height_of_infos = ( v , precise_version ) ->
    p = new DomainsCommonProcessor( v.infos().children() )
    if precise_version
      v.infos().css( 'height' , p.sum_outer_height( true ) )
    else
      v.infos().css( 'height' , p.max_outer_height( true ) )
    return

  set_height_of_domain = (v) ->
    v.domain.css( 'height' , v.infos().outerHeight( true ) )
    return
