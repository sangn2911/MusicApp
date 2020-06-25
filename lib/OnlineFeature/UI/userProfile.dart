import 'dart:ui';

import 'package:MusicApp/Custom/customText.dart';
import 'package:MusicApp/Custom/sizeConfig.dart';
import 'package:MusicApp/Data/mainControlBloC.dart';
import 'package:MusicApp/Data/userModel.dart';
import 'package:MusicApp/OnlineFeature/UI/purchase.dart';
import 'package:MusicApp/OnlineFeature/httpService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';

class UserProfile extends StatefulWidget {

  final MainControllerBloC mainBloC;
  UserProfile(this.mainBloC);


  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  UserModel userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = widget.mainBloC.infoBloC.userInfo.value;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: appBar(context),
        backgroundColor: Colors.black,
        body: Column(
            children: <Widget>[
              profileContainer(false),
              SizedBox(height: 29/640*SizeConfig.screenHeight,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 38, right: 38),
                  child: childList(context),
                ),
              )
            ]
        )
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 45,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.pop(context);
        }
      ),
      title: text("Profile"),
      actions: <Widget>[
        IconButton(
            onPressed: (){},
            icon: Icon(
              IconCustom.settings_1
            ),
        ),
      ],
    );
  }

  Widget profileContainer(bool isVIP){
    //widget.userInfo.printAll();
    return Container(
      width: 500,
      height: 135,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorCustom.orange
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20,),
          avatar(),
          SizedBox(width: 70),
          Column(
            children: <Widget>[
              text("${userInfo.name}"),
              SizedBox(height: 15,),
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorCustom.orange),
                ),
                child: Center(
                  child: InkWell(
                    child: text("VIP",color: userInfo.isVip == 1 ? Colors.amber : Colors.white, size: userInfo.isVip == 1 ? 40 : 20, fontWeight: userInfo.isVip == 1 ? FontWeight.w900 : FontWeight.w400),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Purchase(),
                          );
                        }
                      );
                    },
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget avatar(){
    return CircleAvatar(
      backgroundColor: ColorCustom.orange,
      child: Container(
        child: Icon(
          Icons.person,
          color: Colors.black,
          size: 50,
          )
        ),
      radius: 40,
    );
  }


  Widget childList(BuildContext context){
    return StreamBuilder(
      stream: widget.mainBloC.infoBloC.userInfo,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData) 
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );

        UserModel _userInfo = snapshot.data;
        return ListView(
          children: <Widget>[
            infoListTitle(Icons.mail , "${_userInfo.email}", onPressed: (){
              createPopUp(context, "Enter new email", () async { 
                //print("email");
                int result = await updateInfo(widget.mainBloC.infoBloC.userInfo , customController.text.toString(), _userInfo.name, "updateEmail");
                customController.text = "";
                result == 1 ? createAlertDialog("Update Successfully", context) : createAlertDialog("Check Your Info", context);
              });
            }),
            infoListTitle(Icons.phone, "${_userInfo.phone}", onPressed: (){
              createPopUp(context, "Enter new phone number", () async { 
                int result = await updateInfo(widget.mainBloC.infoBloC.userInfo , customController.text.toString(), _userInfo.name, "updatePhone");
                customController.text = "";
                result == 1 ? createAlertDialog("Update Successfully", context) : createAlertDialog("Check Your Info", context);
              });
            }),
            infoListTitle(Icons.attach_money,"${_userInfo.coin}", onPressed: (){

            }),
            infoListTitle(Icons.keyboard_voice,"Voice Authentication", onPressed: (){
              createVoiceRegister(context, "Voice Register", () { });
            }),
            infoListTitle(Icons.exit_to_app,"Log Out", onPressed: () async {
              final bool response = await logOut(_userInfo.name);
              if (response){
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              }
              else{
                createAlertDialog("Fail to log out", context);
              }
            }),
          ],
        );
      },
    );
  }

  Widget infoListTitle(IconData icon, String str, {void Function() onPressed }){
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 20),
      leading: Icon(
        icon,
        size: 50,
        color: Colors.amber,
      ),
      title: text(str, size: 25),
      trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.amber,
          )
      ),
    );
  }

  final TextEditingController customController = TextEditingController(text: "");

  Future<void> createPopUp(BuildContext context, String title,void Function() function){
    return showDialog(
      context: context, 
      builder: (context){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: TextLato(title,Colors.white, 20, FontWeight.w700),
            content: TextField(
              obscureText: false,
              controller: customController,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                )
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: TextLato("Confirm",Colors.white, 20, FontWeight.w700),
                onPressed: () async{
                  function();
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                elevation: 5.0,
                  child: TextLato("Cancel",Colors.white, 20, FontWeight.w700),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> createVoiceRegister(BuildContext context, String title,void Function() function){
    return showDialog(
      context: context, 
      builder: (context){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 50,vertical: 190),
            backgroundColor: ColorCustom.grey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10),
                  TextLato(title, Colors.white, 25, FontWeight.w700),
                  SizedBox(height: 50),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 100,
                    icon: Icon(
                      Icons.keyboard_voice,
                      color: Colors.white,
                    ),
                    onPressed: (){},
                  ),
                  SizedBox(height: 50),
                  TextLato("Push the button", Colors.white, 25, FontWeight.w700),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget text(String str, {Color color = Colors.white, double size = 20.0, FontWeight fontWeight = FontWeight.w400}){
    return Text(
      str,
      style: TextStyle(
        color: color,
        fontSize: 20.0,
        fontFamily: 'Lato',
        fontWeight: fontWeight,
      ),
    );
  }

}