import os
import os.path

import requests
from flask import Flask, request, Response
from lxml import etree
from werkzeug.exceptions import BadRequest, NotFound

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

@app.route('/')
def home():
    return ''


@app.route('/xslt/<name>')
def xslt(name):
    try:
        with open(os.path.join(BASE_DIR, 'xslt', name + '.xslt')) as f:
            try:
                resp_xml = requests.get(request.args['url']).text
            except KeyError:
                raise BadRequest()
            else:
                input_ = etree.fromstring(resp_xml.encode('utf-8'))
                transform = etree.XSLT(etree.parse(f))
                output = transform(input_)
                return Response(str(output), mimetype='text/xml')
    except IOError:
        raise NotFound()
    except etree.XMLSyntaxError:
        raise BadRequest()

if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
