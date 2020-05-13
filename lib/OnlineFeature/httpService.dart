import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


String url = 'http://10.127.29.30:5000/';

Future<int> createUser(String name, String password, bool isRegister) async{

  String urlTemp;

  if (isRegister) urlTemp = url + 'register';
  else urlTemp = url + 'login';

  final response = await http.post(urlTemp, body: {
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