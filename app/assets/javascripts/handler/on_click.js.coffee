class OnClickHandler

  list = (v) ->
    ary = []
    t = new TwittersProcessor()
    r = new RealTimeInfoProcessor()
    ary.push(t)
    ary.push(r)
    return ary

  process: ->
    # console.log 'OnClickHandler\#process'
    $.each list(@) , ->
      @.set_size_change_event()
    return

window.OnClickHandler = OnClickHandler