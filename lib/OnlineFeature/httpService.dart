import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


String url = 'http://10.127.29.30:5000/'; //localhost

Future<int> createUser(String email, String name, String password) async{

  final response = await http.post(url + 'register',
    body: {
      "email": email,
      "username": name,
      "password": password
    }
  );


  if (response.statusCode == 200){
    print("Response body ${response.body}");
    return 0;
  }
  else if (response.statusCode == 400){
    print("Response body ${response.body}");
    return 1;
  }
  else{
    print("Error: ${response.statusCode}");
    return 2;
  }
  
}


Future<int> verifyUser(String name, String password) async{

  final response = await http.post(url + 'login', 
    body: {
      "username": name,
      "password": password
    }
  );

  if (response.statusCode == 200){
    print("Response body ${response.body}");
    return 0;
  }
  else if (response.statusCode == 400){
    print("Response body ${response.body}");
    return 1;
  }
  else{
    print("Error: ${response.statusCode}");
    return 2;
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