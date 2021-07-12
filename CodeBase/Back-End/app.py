from flask import Flask
from flask import Flask, jsonify,request
import mysql.connector
from config import *
app = Flask(__name__)


mycursor = mydb.cursor()

@app.route('/')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
