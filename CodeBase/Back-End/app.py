import flask
from flask import Flask
from flask import Flask, jsonify,request
import mysql.connector
from config import *
app = Flask(__name__)


mycursor = mydb.cursor()

@app.route('/get_random_activity')
def get_random_activity():
    return "random activity"

@app.route('/get_specific_activity')
def get_specific_activity():
    json_data = flask.request.json
    personCount = json_data['personCount']
    budget = json_data['budget']
    dogFriendly = bool(json_data['dogFriendly'])
    kidFriendly = bool(json_data['kidFriendly'])
    kidPause = bool(json_data['kidPause'])

    return 'specific_activity'

@app.route('/add_activity')
def add_activity():
    return 'activity got added'

@app.route('/delete_activity')
def delete_activity():
    return 'activity got deleted'



if __name__ == '__main__':
    app.run()
