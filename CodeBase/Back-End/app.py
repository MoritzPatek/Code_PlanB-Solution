from random import randrange

import flask
import simplejson as simplejson
from flask import Flask
from flask import Flask, jsonify,request
import mysql.connector
import json
from config import *
app = Flask(__name__)


mycursor = mydb.cursor()

@app.route('/get_random_activity')
def get_random_activity():
    mycursor.execute("Select * from activities")
    activitys = mycursor.fetchall()
    print(activitys)
    if len(activitys) != 0:
        x = randrange(len(activitys))
        # TODO: output tuple to json
        return str(activitys[x]), 200
    return 'no activitys found', 400

@app.route('/get_specific_activity')
def get_specific_activity():
    json_data = flask.request.json
    personCount = json_data['personCount']
    budget = json_data['budget']
    dogFriendly = bool(json_data['dogFriendly'])
    kidFriendly = bool(json_data['kidFriendly'])
    kidPause = bool(json_data['kidPause'])

    if personCount != None and budget != None and dogFriendly != None and kidFriendly != None and kidPause != None:
        sqlSpecificActivity = "Select * from activities where " \
                              "maxPersonCount >= " + str(personCount) + \
                              " and price <= " + str(budget) + \
                              " and dogFriendly = " + str(dogFriendly) + \
                              " and kidFriendly = " + str(kidFriendly) + \
                              " and kidPause = " + str(kidPause)+";"
        mycursor.execute(sqlSpecificActivity)
        result = mycursor.fetchall()
        if len(result) != 0:
            #TODO: output tuple as json
            return mycursor.fetchall(), 200
        return 'there are no events listed with your specific parameters', 400
    else:
        return 'missing attributes', 400

@app.route('/add_activity')
def add_activity():
    #TODO: token required
    json_data = flask.request.json
    activityName = json_data['activityName']
    websiteURL = json_data['websiteURL']
    personCount = json_data['personCount']
    price = json_data['price']
    dogFriendly = bool(json_data['dogFriendly'])
    kidFriendly = bool(json_data['kidFriendly'])
    kidPause = bool(json_data['kidPause'])

    if activityName is None:
        return 'You have to provide an activityname ', 400
    if personCount < 0:
        return 'The person count can not be negative', 400
    if price < 0:
        return 'The price has to be zero or greater then zero, it can not be negative', 400
    if dogFriendly is None:
        return 'You have to provide information for dog owners', 400
    if kidFriendly is None:
        return 'You have to provide information for parents about the situation for kids', 400
    if kidPause is None:
        return 'You have to provide information for parents about the kid pause', 400
    else:
        insertNewActivity = "insert into activities (activityName, websiteURL, maxPersonCount, price, dogFriendly, kidFriendly, kidPause) values ('Musuem for children', Null, Null, 30, false, true, true);"
        mycursor.execute(insertNewActivity)
        mydb.commit()
        return 'New activity got added.', 200





@app.route('/delete_activity')
def delete_activity():
    return 'activity got deleted'

@app.route('/debug')
def debug():
    from collections import defaultdict

    e = defaultdict(list)
    mycursor.execute("select * from activities")
    response = mycursor.fetchall()
    for element in response:
        e[element[0]].append({'name': element[1], 'address': element[2],
                              'budget': element[3], 'url': element[4],
                              'personCount': element[5], 'kidFriendly': element[6],
                              'kidPause': element[7], 'dogFriendly': element[8]})

    json = (simplejson.dumps(e))
    return json, 200


if __name__ == '__main__':
    app.run()
