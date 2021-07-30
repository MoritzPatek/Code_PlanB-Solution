from random import randrange
from collections import defaultdict

import flask
import simplejson as simplejson
from flask import Flask
from flask import Flask, jsonify,request
import mysql.connector
import json
from config import *
from collections import defaultdict
app = Flask(__name__)


mycursor = mydb.cursor()

@app.route('/get_specific_activity', methods=['POST'])
def get_specific_activity():
    json_data = flask.request.json
    print(json_data)
    personCount = json_data['personCount']
    budget = json_data['budget']
    dogFriendly = json_data['dogFriendly']
    kidFriendly = json_data['kidFriendly']
    kidPause = json_data['kidPause']

    if personCount != None and budget != None and dogFriendly != None and kidFriendly != None and kidPause != None:
        sqlSpecificActivity = "Select * from activities where " \
                              "e_personCount >= " + str(personCount) + \
                              " and e_budget <= " + str(budget) + \
                              " and e_dogFriendly = " + str(dogFriendly) + \
                              " and e_kidFriendly = " + str(kidFriendly) + \
                              " and e_kidPause = " + str(kidPause)+";"
        mycursor.execute(sqlSpecificActivity)
        result = mycursor.fetchall()
        if len(result) != 0:
            e = defaultdict(list)
            response = result
            for element in response:
                e[element[0]].append({'imageURL': element[1], 'name': element[2], 'address': element[3],
                                      'budget': element[4], 'url': element[5],
                                      'personCount': element[6], 'kidFriendly': element[7],
                                      'kidPause': element[8], 'dogFriendly': element[9]})

            json = (simplejson.dumps(e))
            return json, 200
        return 'there are no events listed with your specific parameters', 400
    else:
        return 'missing attributes', 400

@app.route('/add_activity')
def add_activity():
    json_data = flask.request.json
    name = json_data['name']
    url = json_data['url']
    address = json_data['address']
    budget = json_data['budget']
    kidFriendly = json_data['kidFriendly']
    dogFriendly = json_data['dogFriendly']
    kidPause = json_data['kidPause']
    personCount = json_data['personCount']
    imageURL = json_data['imageURL']

    if name is None:
        return "A name has to be provided", 400
    if url is None:
        url = ""
    if address is None:
        return "An address has to be provided", 400
    if budget is None:
        budget = "0"
    if kidFriendly is None:
        kidFriendly = "false"
    if dogFriendly is None:
        dogFriendly = "false"
    if kidPause is None:
        kidPause = "false" 
    if int(personCount) <= 0:
        return "personCount has to be over 0", 400
    if personCount is None: 
        personCount = 10000
    if imageURL is None:
        imageURL = "https://i.stack.imgur.com/y9DpT.jpg"
    else:
        insertNewActivity = "insert into activities (activityName, websiteURL, maxPersonCount, price, dogFriendly, kidFriendly, kidPause) values ('Musuem for children', Null, Null, 30, false, true, true);"
        mycursor.execute(insertNewActivity)
        mydb.commit()
        return 'New activity got added.', 200


@app.route('/delete_activity')
def delete_activity():
    json_data = flask.request.json
    id = json_data['id']
    name = json_data['name']
    deleteActivitySQL = 'delete from activities where id ='+ str(id) + ' and name = ' + str(name) 
    mycursor.execute(deleteActivitySQL)
    mydb.commit()

@app.route('/debug')
def debug():

    e = defaultdict(list)
    mycursor.execute("select * from activities")
    response = mycursor.fetchall()
    for element in response:
        e[element[0]].append({'imageURL':element[1], 'name': element[2], 'address': element[3],
                              'budget': element[4], 'url': element[5],
                              'personCount': element[6], 'kidFriendly': element[7],
                              'kidPause': element[8], 'dogFriendly': element[9]})

    json = (simplejson.dumps(e))
    return json, 200


if __name__ == '__main__':
    app.run()

