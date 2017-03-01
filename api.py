
from flask import Flask, request, jsonify
import joblib
model = joblib.load('model/model.pkl')
app = Flask("api")

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/predict', methods=['POST'])
def predict_api():
    """Endpoint for predicting truthfulness of a review."""
    text = request.get_json()['text']
    prediction = model.predict_proba([text]).tolist()[0]
    return jsonify(prediction=prediction)

@app.route('/')
def test():
    return jsonify({"status":"success"})

@app.route('/shutdown', methods=['POST'])
def shutdown():
    shutdown_server()
    return 'Server shutting down...'
