import song
from flask import jsonify

def song(result,db):
    name =[]
    song = db.song
    for x in song.find({},{'title':1,'artist':1,'_id':1,'id':1}):        
        
        x['_id'] = str(x['_id'])
        name.append(x)
    return jsonify(
        name = name
    ),200

def play(result,db):
    song = db.song
    id = result['id']
    songRes = song.find_one({'id' : id},{'title':1,'artist':1,'_id':0,'link':1,'duration':1})
    return jsonify(
        songRes
    ),200