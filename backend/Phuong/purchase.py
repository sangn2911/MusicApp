import main
from flask import jsonify
from datetime import datetime

def purchase(request, db):
    trans = db.transaction
    user_wallet = db.wallet
    user = db.userInfo
    username = request['username']
    itemname = request['name']
    itemtype = request['type']
    coin = request['coin']
    password = request['password']

    # Check password, hiển thị confirm purchase (app)
    confirm_password = user.find_one({'username': username})['password']
    if password != confirm_password:
        return jsonify(
            statusCode = 400,
            message = 'Wrong Password'
                ), 400
    
    if itemname == 'VIP':
        user.update(
            {'username':username},
            {
                '$set':{'status': 1},
            },
            upsert= True
        )

    #update wallet
    user_wallet.update(
        {"username": username},
        {
            "$inc": {
                "coin": -int(coin),
            }
        }, 
    )

    #Insert transaction
    trans.insert({
        'username': username,
        'coin': coin,
        'item': {
            'name': itemname,
            'type': itemtype,
        },
        'date': datetime.now()
    }
    )

    return jsonify(
    statusCode = 201,
    message = 'Succeed'
                ), 200

    


