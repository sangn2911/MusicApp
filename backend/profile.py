import main
from flask import jsonify

def show(db):
    users = db.userInfo
    return jsonify(
    statusCode = 201,
    message = 'Succeed'
                )    