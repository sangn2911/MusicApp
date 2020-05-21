import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


String url = 'http://25.40.136.16:5000/home'; //localhost

Future<int> createUser(String email, String name, String password) async{

  final response = await http.post(url,
    body: {
      "service": "signup",
      "email": email,
      "username": name,
      "password": password
    }
  );

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


Future<int> verifyUser(String name, String password) async{

  final response = await http.post(url, 
    body: {
      "service": "login",
      "username": name,
      "password": password
    }
  );

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