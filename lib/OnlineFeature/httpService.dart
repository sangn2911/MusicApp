import 'dart:convert';

//import 'package:MusicApp/Data/playlistModel.dart';
import 'package:MusicApp/Data/infoControllerBloC.dart';
import 'package:MusicApp/Data/songModel.dart';
import 'package:MusicApp/Data/userModel.dart';
import 'package:MusicApp/OnlineFeature/UI/purchase.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

String url1 = 'http://25.19.229.40:5000/'; //localhost

String url = 'http://25.40.136.16:5000/';

//User Information

Future<int> createUser(String email, String name, String password) async{

  Map data = {
    "service": "signup",
    "email": email,
    "username": name,
    "password": password
  };  

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  
  if (response.statusCode == 200){
    print("Response body: ${response.body}");
    return 0;
  }
  else if (response.statusCode == 400){
    print("Response body: ${response.body}");
    return 1;
  }
  else{
    print("Error: ${response.statusCode}");
    return 2;
  }
  
}


Future<UserModel> verifyUser(String name, String password) async{

  Map data = {
    "service": "login",
    "username": name,
    "password": password
  };

  String body = json.encode(data);

  final response = await http.post(url, 
    body: body,
  );

  print("Status Code: ${response.statusCode}");

  if (response.statusCode == 200){
    print("Response body: ${response.body}");
    UserModel userInfo = userModelFromJson(response.body);
    return userInfo;
  }
  else {
    print("Response body: ${response.body}");
    return null;
  }
  
}

Future<bool> logOut(String name) async{

  Map data = {
    "service": "logout",
    "username": name,
  };

  String body = json.encode(data);

  final response = await http.post(url, 
    body: body,
  );

  print("Status Code: ${response.statusCode}");

  if (response.statusCode == 200){
    return true;
  }
  else {
    return false;
  }

}


Future<int> buyVipAndSong(InfoControllerBloC userBloC, String password ,String type, int coin, {String songID = ""}) async{

  Map data;
  if(type == "status"){
    data = {
      "service": "purchase",
      "username": userBloC.userInfo.value.name,
      "password": password,
      "type": type,
      "name": "VIP",
      "coin": coin,
    };
  } else {
    data = {
      "service": "purchase",
      "username": userBloC.userInfo.value.name,
      "password": password,
      "type": type,
      "name": songID,
      "coin": coin,
    };
  }

  String body = json.encode(data);

  final response = await http.post(url, 
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Message: ${response.body}");
  var jsondecode = json.decode(response.body);

  if (response.statusCode == 200){
    userBloC.userInfo.value.isVip = 1;
    userBloC.userInfo.value.coin = jsondecode["coin"];
    userBloC.userInfo.add(userBloC.userInfo.value);
    return 0;
  }
  else if(jsondecode["message"] == "Not enough coin!"){
    return 1;
  }
  else if(jsondecode["message"] == "Wrong Password"){
    return 2;
  }
  else 
    return 3;

}

Future<int> transactionForCoin(InfoControllerBloC userBloC, int coin) async{

  Map data = {
    "username": userBloC.userInfo.value.name,
    "coin": coin,
  };

  String body = json.encode(data);

  final response = await http.post(url + "bank", 
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Message: ${response.body}");
  var jsondecode = json.decode(response.body);

  if (response.statusCode == 200){
    userBloC.userInfo.value.coin = jsondecode["coin"];
    userBloC.userInfo.add(userBloC.userInfo.value);
    return 0;
  }
  else {
    return 1;
  }

}

Future<int> updateInfo(BehaviorSubject<UserModel> _userInfo, String value, String username, String service) async{
  
  Map data = {};
  UserModel initUser;

  if (service == "updateEmail") {
    data = {
      "service": service,
      "username": username,
      "email": value,
    };
  }
  else if (service == "updatePhone"){
    data = {
      "service": service,
      "username": username,
      "phone": value,
    };
  } 

  String body = json.encode(data);

  final response = await http.post(url + "update",
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Update Body: ${response.body}");

  UserModel userInfo = _userInfo.value;
  if (response.statusCode == 200){
    
    if (service == "updateEmail"){
      String value = json.decode(response.body)["email"];
      initUser = UserModel(name: userInfo.name, email: value, phone: userInfo.phone, coin: userInfo.coin, isVip: userInfo.isVip); 
    }
    else if (service == "updatePhone"){
      String value = json.decode(response.body)["phone"];
      initUser = UserModel(name: userInfo.name, email: userInfo.email, phone: value, coin: userInfo.coin, isVip: userInfo.isVip);
    }

    _userInfo.add(initUser);
    return 1;
  }
  else {
    return 0;
  }

}

//Activity with song database

Future<List<Song>> getfavourite() async{

  //return [];

  Map data = {
    "service": "favouriteLst",
  };

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  // print("Status Code: ${response.statusCode}");
  // print("Body Code: ${response.body}");
  
  if (response.statusCode == 200){
    var jsondecode = json.decode(response.body);
    List<Song> songs = List<Song>.from(jsondecode["favourite"].map((x) => Song.fromJson(x)));
    print("Song List: $songs");
    return songs;
  }
  else {
    return [];
  }

}

Future<Song> getSong(String id) async{

  Map data = {
    "service": "songLink",
    "_id": id,
  };

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  print("Status Code: ${response.statusCode}");

  if (response.statusCode == 200){
    print("Body Song: ${response.body}");
    var jsondecode = json.decode(response.body);

    Song song = Song(
      null, 
      jsondecode["artist"] == null ? "Unknown" : jsondecode["artist"], 
      jsondecode["title"] == null ? "Unknown" : jsondecode["title"], 
      "Unknown",
      null, 
      jsondecode["duration"], 
      jsondecode["link"],
      null,
      id,
      );

    return song;
  }
  else {
    return null;
  }

}

Future<List<String>> fetchPlaylist(String username) async{

  Map data = {
    "service": "myPlaylist",
    "username": username,
  };

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Body: ${response.body}");

  if (response.statusCode == 200) {
    var jsondecode = json.decode(response.body);
    List<dynamic> playlists = jsondecode;
    List<String> result = playlists.cast<String>().toList();
    return result;
  }
  else {
    return null;
  }

}


Future<List<String>> createPlaylist(String name, String username) async{

  Map data = {
    "service": "createPlaylist",
    "playlistname": name,
    "username": username,
  };

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  

  if (response.statusCode == 200) {
    print("Body Playlist: ${response.body}");
    var jsondecode = json.decode(response.body);


    List<dynamic> playlists = jsondecode;
    List<String> result = playlists.cast<String>().toList();
    return result;
  }
  else {
    return null;
  }

}

Future<int> playlistAdd(String playlistName, String username, String id) async{

  Map data = {
    "service": "addSong",
    "playlistname": playlistName,
    "username": username,
    "title": id,
  };

  String body = json.encode(data);

  final response = await http.post(url,
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Body: ${response.body}");

  if (response.statusCode == 200){
    //var jsondecode = json.decode(response.body);
    return 1;
  }
  else {
    return 0;
  }

}

createAlertDialog(String str, BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Center(
        child: Text(
          str,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red
          ),
        ),
      ),
    );
  });
}