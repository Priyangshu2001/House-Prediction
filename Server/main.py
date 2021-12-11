import json
import pickle

from flask import Flask, request, jsonify


app = Flask(__name__)
loaded_model = pickle.load(open("model.pickle","rb"))


@app.route("/result", methods=["POST"])
def getLocation():
    data = request.get_json()
    bhk = data['bhk_no']
    sqr_ft = data['sqft']
    resale = data['resale']
    long = data['long']
    lat = data['lat']
    result = loaded_model.predict([[bhk, sqr_ft, resale, long, lat]])
    print (result);
    return jsonify({
        "predicted": result[0]
    })


if __name__ == '__main__':
    app.run()
