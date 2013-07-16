
kobanMaster = $("<div/>").addClass('koban-container')
    .css('display', 'none')
    .prependTo($ "body")
    .hide()
header = $("<div/>")
    .addClass('koban-header')
    .prependTo(kobanMaster)
logo = $("<div class='koban-logo'>koban</div>")
    .appendTo(header)
logo.click(() -> kobanMaster.find('.koban-piece').toggle())
header.append($("<div class='clear'></div>"))


url = window.location.href
data = {type: "fetch", url: url}

chrome.extension.sendMessage data, (response) ->
    if response? and response.length > 0
        kobanMaster.show().find('.koban-piece').show()
        _.each response, (html) ->
            newel = $("<div class='koban-piece'></div>")
                .addClass('koban-piece')
                .append($ html)
            kobanMaster.append(newel)
    else
        kobanMaster.hide()


# google calendar hack #
gcal = /google.com\/calendar/
if gcal.test url
  rejigger = () ->
    cols = $(".tg-col")
    for col in _.uniq(cols, (col) -> $(col).position().left)
      col = $(col)
      chips = col.find(".chip")
      size2chips = {}
      for chip in chips
        chip = $(chip)
        continue if chip.css("display") == "none"
        key = [col.position().left, chip.position().top, chip.height(), chip.find(".evt-lk").text()]
        console.log key
        size2chips[key] = [] unless key of size2chips
        size2chips[key].push chip

      _.each size2chips, (chips, key) ->
        return if chips.length <= 1
        console.log "chips: #{chips}"
        first = chips[0]
        width = first.width()
        for rest in _.rest chips
          width += rest.width()
          rest.remove()
        console.log [col.width(), first.width()]
        first.width "#{Math.min(width, col.width())/(col.width()+1)}%"

  grid = $("#gridcontainer")
  cache = {}
  grid.on "DOMSubtreeModified", (ev) ->
    tstamp = ev.timeStamp
    return if tstamp of cache
    cache[tstamp] = yes
    rejigger()
    if _.size(cache) > 500
      cache = {}
      cache[tstamp] = yes

    
