import 'package:MusicApp/OnlineFeature/UI/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/sizeConfig.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';

class UserProfile extends StatelessWidget {

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
      leading: BackButton(
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
              text("Edgar Wright"),
              SizedBox(height: 15,),
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorCustom.orange),
                ),
                child: Center(
                  child: text(
                    "VIP",
                    color: isVIP ? Colors.amber : Colors.white
                  )
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
    return ListView(
        children: <Widget>[
          infoListTitle(Icons.mail , "edgar@gmail.com", onPressed: (){}),
          infoListTitle(Icons.phone, "0919246969", onPressed: (){}),
          infoListTitle(Icons.attach_money,"999.9", onPressed: (){}),
          infoListTitle(Icons.shopping_cart,"Premium User", 
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Purchase(),
                  );
                }
                );
            }),
          infoListTitle(Icons.exit_to_app,"Log out", onPressed: (){}),
        ],
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

  Widget text(String str, {Color color = Colors.white, double size = 20.0}){
    return Text(
      str,
      style: TextStyle(
        color: color,
        fontSize: 20.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
    );
  }

}