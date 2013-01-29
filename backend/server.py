from gevent.pywsgi import WSGIServer # must be pywsgi to support websocket
from geventwebsocket.handler import WebSocketHandler
from flask import Flask, request, render_template, g, redirect
from pyquery import PyQuery as pq
import json
import requests
import pdb
import traceback

class Handlers:
    """
    Manager for url->content extractor mappings
    """
    def __init__(self):
        self.s_handlers = {}
        self.f_handlers = {}

    def put(self, matcher, f):
        """
        @param matcher is string and do exact match or a boolean function
        @param f call back that takes the actual url as input and returns
                 a list of HTML fragments to add to the page
        """
        if isinstance(matcher, basestring):
            self.s_handlers[matcher] = f
        else:
            self.f_handlers[matcher] = f

    def run(self, url):
        ret = []
        if url in self.s_handlers:
            ret.extend(self.s_handlers[url](url))
        for matcher, cb in self.f_handlers.iteritems():
            if matcher(url):
                ret.extend(cb(url))
        return filter(bool, ret)




app = Flask(__name__)
handlers = Handlers()

@app.route('/', methods=['POST', 'GET'])
def getit():
    url = request.form.get('url', request.args.get('url', None))
    print url
    contents = handlers.run(url)
    return json.dumps({'contents':contents})

def fetch(url):
    try:
        html = requests.request('GET', url).content
    except:
        try:
            html = requests.request('GET', 'http://%s' % url).content
        except:
            html = None
    return html



def csail_webmail(start_url):
    html = fetch('https://webmail.csail.mit.edu/horde/login.php')
    dom = pq(html)
    forms = dom.find('form')
    contents = []
    for form in forms:
        tag = form.tag
        attrs = ' '.join(["%s = '%s'" % (k,v) for k,v in form.items()])
        contents.append("<%s %s>%s</%s>" % (tag, attrs, pq(form).html(), tag))
    return contents
handlers.put('http://webmail.csail.mit.edu/', csail_webmail)



if __name__ == "__main__":
    app.debug = True
    address = ('', 8888)
    http_server = WSGIServer(address, app, handler_class=WebSocketHandler)
    print "running"
    http_server.serve_forever()
