from werkzeug.wrappers import Request, Response, ResponseStream
import time
import json

class middleware():
    '''
    Simple WSGI middleware
    '''

    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        request = Request(environ)
        print("\nentering middleware.......\n")
        print("incoming request -> \n",request)
        print("incoming headers -> \n",request.headers)
        print("\nexiting middleware........\n")
        return self.app(environ, start_response)

from flask import Flask, request, jsonify
app = Flask(__name__)
app.wsgi_app = middleware(app.wsgi_app)


@app.route('/users/login', methods=['GET','POST'])
def validate():
    return jsonify(
        username="avirup",
       password="123"
        )

if __name__ == '__main__':
	app.run()