import main
from flask import jsonify

def trans(result, db):
    user_wallet = db.wallet
    cash = result['cash']   
    username = result['username']
    
    if cash <= 20000:
        return jsonify(
            statusCode = 400,
            message = 'Transaction Denied'
                ), 400

    user_wallet.update(
        {"username": username},
        {
            "$inc": {
                "coin": cash,
            }
        }, 
        upsert = True,
    )

    newcoin = user_wallet.find_one({'username': username})['coin']

    return jsonify(
    statusCode = 201,
    message = 'Succeed',
    coin = int(newcoin)
                ), 200

    