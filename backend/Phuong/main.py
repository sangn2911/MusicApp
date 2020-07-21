from flask import Flask, request, session
from flask_pymongo import PyMongo
import bcrypt
import auth, purchase, profile, bank
from flask import jsonify
from flask_login import LoginManager, UserMixin
app = Flask(__name__)
app.secret_key = "super secret key"

app.config["MONGO_URI"] = "mongodb://localhost:27017/MusicApp"
app.config["MONGO_DNAME"] = "MusicApp"

mongo = PyMongo(app)
db = mongo.db
#

@app.route("/", methods = ['POST','GET'])
def homepage(): 
    if request.method == 'POST':
        result = request.get_json(force=True)
        service = result["service"]
        username = result["username"]
        session["username"] = username
        if service == 'login':
            return auth.login(result, db)
        elif service == 'signup':
            return auth.register(result, db)
        elif service == 'purchase': 
            return purchase.purchase(result, db)
        # elif service == 'update':
        #     return ???    
        if service == 'logout':
            return auth.logout(result, db)
    return 'Welcome'

@app.route("/bank", methods = ['POST', 'GET'])
def autobank():
    if request.method=='GET':
        result = request.get_json(force=True)
        return bank.trans(result, db)
    return 'Welcome to your bank'

