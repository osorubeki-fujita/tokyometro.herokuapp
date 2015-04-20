class MainContents
  constructor: ->

  contents = (v) ->
    return $('div#contents')

  left_contents = (v) ->
    return $( 'div#left_contents' )

  main_content_center = (v) ->
    return $( 'div#main_content_center' )

  main_content_wide = (v) ->
    return $( 'div#main_content_wide' )

  right_contents = (v) ->
    return $( 'div#right_contents' )

  added_to_max_height = (v) ->
    return 32

  padding_top_of_contents = (v) ->
    return 8 # $( 'div#contents' ).paddingTop

  padding_bottom_of_contents = (v) ->
    return 8 # $( 'div#contents' ).paddingBottom

  max_height = (v) ->
    # console.log 'MainContents\#max_height'
    ary = [ left_contents(v).outerHeight() , main_content_center(v).outerHeight() , main_content_wide(v).outerHeight() , right_contents(v).outerHeight() ]
    # console.log ary
    return Math.max.apply( null , ary ) + added_to_max_height(v)

  process: ->
    # console.log 'MainContents\#process'

    _max_height = max_height(@)
    # 各要素に高さを設定
    contents(@).css( 'height' , _max_height + padding_top_of_contents(@) + padding_bottom_of_contents(@) )
    left_contents(@).css( 'height' , _max_height )
    main_content_center(@).css( 'height' , _max_height )
    main_content_wide(@).css( 'height' , _max_height )
    right_contents(@).css( 'height' , _max_height )
    return 

window.MainContents = MainContents