layoutManager = new KobanLayout


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


