import os
import requests
from flask import Flask, render_template, request


KUBERNETES_SERVICE_HOST = os.getenv('KUBERNETES_SERVICE_HOST')


app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def index():
    errors = []
    results = {}
    if request.method == "POST":
        # get url that the person has entered
        data = request.form['data']
        r = requests.post(
            f"http://backend.default.10.105.62.247.sslip.io/request",
            json={
                'data': data
            }
        )
        if r:
            results = r.json()
            app.logger.info(f'This is request output {results}')
    return render_template('form.html', errors=errors, results=results)


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))