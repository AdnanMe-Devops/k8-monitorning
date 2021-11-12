import time
import random

from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
PrometheusMetrics(app)

@app.route('/one')
def first_route():
    time.sleep(random.random() * 0.2)
    return 'ok'

@app.route('/two')
def the_second():
    time.sleep(random.random() * 0.4)
    return 'ok'

@app.route('/three')
def test_3rd():
    time.sleep(random.random() * 0.6)
    return 'ok'

@app.route('/four')
def fourth_one():
    time.sleep(random.random() * 0.8)
    return 'ok'

@app.route('/error')
def oops():
    return ':(', 500

if __name__ == '__main__':
    app.run('0.0.0.0', 5000, threaded=True)
//The api.py file contains the Python source code which implements the example API. In particular take note of the following:

Line 5 - imports a PromethusMetrics module to automatically generate Flask based metrics and provide them for collection at the default endpoint /metrics
Line 10-32 - implements 5 x API endpoints:
/one
/two
/three
/four
/error
-All example endpoints, except for the error endpoint, introduce a small amount of latency which will be measured and observed within both Prometheus and Grafana.
-The error endpoint returns an HTTP 500 server error response code, which again will be measured and observed within both Prometheus and Grafana.
The Docker container image containing this source code has already been built using the tag cloudcademydevops/api-metrics
