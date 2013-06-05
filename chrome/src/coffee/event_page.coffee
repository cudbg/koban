class ManualKobanController
    constructor: (urlxform) ->
        chrome.extension.onMessage.addListener @onMessage

        @urlxform = urlxform
        @$body = $ 'body'
        console.log @$body



    encodeHtml: (html) -> html

    onMessage: (data, sender, sendResp) =>
        if data.type is 'fetch'
            url = data.url
            @fetch url, (resp) => sendResp resp
        true

    fetch: (url, cb) ->
        $.get 'http://localhost:8888', {url:url}, (data) ->
            console.log data
            json = JSON.parse data
            console.log json
            window.json = json
            cb json.contents






$ ->
    urlxform = (url) ->
        ret = "http://localhost:8888?url=#{url}"
        console.log ret
        ret


    mkoban = new ManualKobanController urlxform
    window.mkoban = mkoban

