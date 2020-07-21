from flask import Flask, request, url_for,jsonify
from flask_pymongo import PyMongo 
from pymongo import MongoClient
import playlist,listsong

app = Flask(__name__)
app.config['MONGO_URI'] = 'mongodb://127.0.0.1:27017'
client = MongoClient('mongodb://127.0.0.1:27017')
mongo = PyMongo(app)
db=client.MusicApp # select database
playlist_coll=db.song
play = db.playList
@app.route('/', methods = ['POST','GET'])
def home():
    play.insert({'name':'lovely','playlistname':'not at all','song':[]})
    res = play.find_one({'name':'Uchiha Obito'})
    res['_id'] = str(res['_id'])
    return jsonify(
        message = 'Add completed',
        res = res
        
    ),200
    if request.method =='POST':
        result = request.get_json(force = True)
        type = result["service"]
        if type == 'favouriteLst':
            return playlist.song(result,db)
        if type == 'songLink':
            return playlist.play(result,db)
        if type == 'createPlaylist':
            return listsong.createPlayList(result,db)
            
    return 'OK'