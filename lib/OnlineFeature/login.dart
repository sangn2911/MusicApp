import 'package:MusicApp/OfflineFeature/downloadlist.dart';
import 'package:MusicApp/ParentWidget.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/sizeConfig.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/OnlineFeature/signUp.dart';
import 'package:MusicApp/OnlineFeature/httpService.dart';

class Login extends StatelessWidget {

  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //SizeConfig().printAllDetail();
    final rootIW = ParentdWidget.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight*52/640,),
            logoWidget(),
            SizedBox(height: SizeConfig.screenHeight*31/640,),
            textInput(),
            SizedBox(height: SizeConfig.screenHeight*33/640,),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth / 2 - 82),
                  child: signInButton(context),
                ),
                signInWithVoiceButton(),
              ]
            ),
            SizedBox(height: SizeConfig.screenHeight*8/640,),
            signUp(context),
            SizedBox(height: SizeConfig.screenHeight*8/640,),
            offlineButton(context,rootIW),
          ],
        ),
      ),
    );
  }

  Widget logoWidget(){
    return Container(      
      width: 250.0,
      height: 150.0,
      child: Icon(
        IconCustom.mymusic,
        color: ColorCustom.orange,
        size: 100,
      ),
    );
  }

  Widget textInput(){
   return Padding(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth*5/36,top: 0.0,right: SizeConfig.screenWidth*5/36,bottom: 0),
      child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text("Username or Email:"),
            textField(input: usernameInput,hint: "example@example.com"),
            SizedBox(height: SizeConfig.screenHeight*38/640,),
            text("Password:"),
            textField(input: passwordInput),
          ],
        ),
      ),
    );
 }

  Widget text(String str){
    return Text(
      str,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
    );
  }

  Widget textField({TextEditingController input, String hint = ""}){
    return TextField(
      controller: input,
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w300,
          fontSize: 18.0,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        filled: true,
        fillColor: ColorCustom.orange,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.black)
        )
      ),
      showCursor: true,
      cursorColor: Colors.black,
    );
  }

  Widget signInWithVoiceButton(){
    return IconButton(
        onPressed: (){
          print("Voice Authentication");
        },
        iconSize: 35,
        icon: Icon(
          Icons.mic,
          color: Colors.green.withBlue(135).withOpacity(0.9),
        ),
      );
  }

  Widget signInButton(BuildContext context){
    return ButtonTheme(
      height: 35,
      minWidth: 164,
      buttonColor: Colors.white,
      child: RaisedButton(
        onPressed: (() async{
          
          final username = usernameInput.text;
          final password = passwordInput.text;

          final int isSuccess = await verifyUser(username, password);

          if (isSuccess == 1)
            createAlertDialog("Check your info",context);
          else if (isSuccess == 0) {
            createAlertDialog("Sign In Successfully",context);
          }
          else
            createAlertDialog("Fail",context);

        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black)
        ),
        child: Text(
          "Sign In",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't Have An Account? ",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        GestureDetector(
          onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUp(),
                )
              );
            },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              color: ColorCustom.orange,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  
  Widget offlineButton(BuildContext context,ParentdWidget rootIW){
    return ButtonTheme(
      height: 35,
      minWidth: 165,
      buttonColor: Colors.white,
      child: RaisedButton(
        onPressed: ((){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Downloadlist(rootIW.fileData, rootIW)
            )
          );
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black)
        ),
        child: Text(
          "Offline",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

}