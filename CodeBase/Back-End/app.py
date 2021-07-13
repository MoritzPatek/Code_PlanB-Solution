import flask
from flask import Flask
from flask import Flask, jsonify,request
import mysql.connector
from config import *
app = Flask(__name__)


mycursor = mydb.cursor()

@app.route('/get_random_activity')
def get_random_activity():
    #TODO: select random activity out of db
    sqlGetRandomActivity = "Select * from activities"
    mycursor.execute(sqlGetRandomActivity)
    activitys = mycursor.fetchall()

    print(activitys)
    #TODO: output tuple to json
    if len(activitys) != 0:
        return 'random activity', 200
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
        #TODO: query for db
        sqlSpecificActivity = "S"
        mycursor.execute(sqlSpecificActivity)
        if len(mycursor.fetchall()) != 0:
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

    #TODO: evaluate data
    insertNewActivity = "insert into activities (activityName, websiteURL, maxPersonCount, price, dogFriendly, kidFriendly, kidPause) values ('Musuem for children', Null, Null, 30, false, true, true);"
    mycursor.execute(insertNewActivity)
    mydb.commit()
    return "new user got added, check emails to verify account"

@app.route('/delete_activity')
def delete_activity():
    return 'activity got deleted'

@app.route('/debug')
def debug():
    mycursor.execute("select * from activities")
    print(mycursor.fetchall())
    return 'debug ended, watch terminal for result', 200



if __name__ == '__main__':
    app.run()
