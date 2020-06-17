import song
from flask import jsonify

def createPlayList(result,db):
    username= result['username']
    listname = result['playlistname']
    play = db.playList
    play.insert({'name':username,'playlistname':listname})

    

    return jsonify(
        message = 'Add completed',
        
    ),200
