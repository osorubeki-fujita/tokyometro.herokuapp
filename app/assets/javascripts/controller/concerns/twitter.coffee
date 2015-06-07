class TwittersProcessor

  constructor: ( @domain = $( '#twitters' ) ) ->
  
  has_twitter_info = (v) ->
    return v.domain.length > 0

  content_header = (v) ->
    return v.domain
      .children( '.content_header' )
      .first()

  button_domain = (v) ->
    return content_header(v)
      .children( '.size_changing_button' )
      .first()

  button = (v) ->
    return button_domain(v)
      .children( 'button' )
      .first()

  i_in_button = (v) ->
    return button(v)
      .children( 'i' )
      .first()

  process: ->
    if has_twitter_info(@)
      process_header(@)
    return

  process_header = (v) ->
    t = new ContentHeaderProcessor( content_header(v) )
    t.process()
    return

  embed_script: ->
    # <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
    return !( function_for_embed_script(@) )

  function_for_embed_script = (v) ->
    d = document
    s = "script"
    id = "twitter-wjs"
    js = null
    fjs = d.getElementsByTagName(s)[0]
    if /^http:/.test(d.location)
      p = 'http'
    else
      p = 'https'
    unless d.getElementById( id )
      js = d.createElement(s)
      js.id = id
      js.src = p + "://platform.twitter.com/widgets.js"
      fjs.parentNode.insertBefore( js , fjs )
    return

  set_size_change_event: ->
    _this = @
    button(@).on 'click' , ->
      _this.change_display_settings()
      return
    return

  change_display_settings: ->
    d = new DisplaySettingsOnClick( @domain , button(@) , i_in_button(@) )
    d.process()
    return

window.TwittersProcessor = TwittersProcessor
