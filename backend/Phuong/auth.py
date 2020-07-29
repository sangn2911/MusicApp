import main
from flask import jsonify

def register(request, db):
    users = db.userInfo 
    password = request['password']
    username = request['username']
    email = request['email']
    exist_user = users.find_one({'username': username})
    if exist_user is None:
        users.insert({'username': username, 'password': password, 'email': email, 'status': 0, 'isLog': 0, 'phone': "000"})
    else:
        return jsonify(
            statusCode = 400,
            message = 'Existed'
                ), 400
    return jsonify(
    statusCode = 201,
    message = 'Succeed'
                ), 200


def login(request, db):
    users = db.userInfo 
    password = request['password']
    username = request['username']
    exist_user = users.find_one({'username': username})

    if exist_user is None:
        return jsonify(
            statusCode = 400,
            message = 'NotExisted'
                ), 400

    if exist_user['isLog'] == 1:
        return jsonify(
            statusCode = 400,
            message = 'Already logged in!'
                ), 400    

    users.update(
            {'username':username},
            {
                '$set':{'isLog': 1},
            },
            upsert= True
        )
    wallet = db.wallet
    coinn = wallet.find_one({'username': username})['coin']
    email = exist_user['email']
    phone = exist_user['phone']
    status = exist_user['status']

    return jsonify(
        statusCode = 201,
        username = username,
        email = email,
        phone = phone,
        status = status,
        coin = coinn,
                    ), 200


def logout(result, db):
    username = result["username"]
    users = db.userInfo 
    users.update(
            {'username':username},
            {
                '$set':{'isLog': 0},
            },
            upsert= True
        )
    return jsonify(
        statusCode = 201,
                    ), 200