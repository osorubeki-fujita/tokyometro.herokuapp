class OnPageChangeHandler

  process: ->
    # console.log 'OnPageChangeHandler'
    p = new LinkDomainsToSetHoverEvent()
    p.process()
    return

$( document ).on 'page:change' , ->
  h = new OnPageChangeHandler()
  h.process()
  return
