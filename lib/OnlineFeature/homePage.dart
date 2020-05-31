import 'package:MusicApp/OnlineFeature/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/sizeConfig.dart';


class HomePage extends StatelessWidget {

  Widget text(String str, Color color , double size, FontWeight fontweight){
    return Text(
      str,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lato',
        fontWeight: fontweight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0/640 * SizeConfig.screenHeight),
        child: appBar(context)
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
            child: text("Recently Play", Colors.white, 20, FontWeight.w700),
          ),
          SizedBox(height: 10/640 * SizeConfig.screenHeight),
          Container(
            padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
            height: 170/640 * SizeConfig.screenHeight,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index){
                return musicPresentation(IconCustom.album_1, "Song $index");
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
            child: text("Favorite albums and songs", Colors.white, 20, FontWeight.w700),
          ),
          SizedBox(height: 10/640 * SizeConfig.screenHeight),
          Container(
            padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
            height: 170/640 * SizeConfig.screenHeight,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index){
                return musicPresentation2(IconCustom.album_1, "Song $index", "Artist $index");
              },
            )
          ),
          Expanded(child: Container()),
          Container(
            color: ColorCustom.orange,
            height: 70,
            child: Center(child: text("---Upcoming---", Colors.white, 20, FontWeight.w700)),
          ),
          buttonSet(),          
        ],
      ),
    );
  }

  Widget appBar(BuildContext context){
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        iconSize: 30,
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile())
          );
        }
      ),
      title: text("Home", Colors.white ,20, FontWeight.w700),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconCustom.settings_1), 
          onPressed: (){}
        ),
      ],
    );
  }

  // Widget musicButton(){
  //   return 
  // }

  Widget musicPresentation(IconData icon, String title){
    return Container(
      width: 130/360 * SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          IconButton(
            padding: EdgeInsets.all(0),
            // constraints: BoxConstraints(
            //   maxHeight: 150/640 * SizeConfig.screenHeight,
            // ),
            iconSize: 110/640 * SizeConfig.screenHeight,
            icon: Container(
              color: ColorCustom.orange,
              child: Icon(
                Icons.music_note,
                color: Colors.black,
              ),
            ),
            onPressed: (){
              print("Select song $title");
            },
          ),
          SizedBox(height: 5),
          text(title, Colors.white, 20, FontWeight.w700),
        ]
      ),
    );
  }

  Widget musicPresentation2(IconData icon, String title, String artist){
    return Container(
      width: 130/360 * SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          IconButton(
            padding: EdgeInsets.all(0),
            iconSize: 110/640 * SizeConfig.screenHeight,
            icon: Container(
              color: ColorCustom.orange,
              child: Icon(
                Icons.music_note,
                color: Colors.black,
              ),
            ),
            onPressed: (){
              print("Select song $title");
            },
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    text(title, Colors.white, 20, FontWeight.w700),
                    text(artist, ColorCustom.grey1, 14, FontWeight.w400),
                  ]
                ),
              ),
              SizedBox(width: 30/110 * (110/640 * SizeConfig.screenHeight)),
              SizedBox(
                  height: 25/640 * SizeConfig.screenHeight,
                  width: 25/640 * SizeConfig.screenHeight,
                  child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 25/360 * SizeConfig.screenWidth,
                    ), 
                  onPressed: (){
                    print("Buy $title");
                  }),
              )
            ]
          )
        ]
      ),
    );
  }

  


  Widget buttonSet(){
    return Container(
      height: 85/640 * SizeConfig.screenHeight,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonWidget(Icons.home, "Home",
              function: (){}
            ),
            SizedBox(width: 40),
            buttonWidget(Icons.search, "Search",
              function: (){}
            ),
            SizedBox(width: 40),
            buttonWidget(Icons.library_music, "Library",
              function: (){}
            ),
            SizedBox(width: 40),
            buttonWidget(Icons.shopping_cart, "VIP",
              function: (){
                print("VIPBUTTON");
              }
            ),
          ],
        )
      ),
    );
  }

  Widget buttonWidget(IconData icon, String str, {void Function() function}){
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        IconButton(
          iconSize: 40,
          icon: Icon(
            icon,
            color: Colors.white,    
          ),
          onPressed: function,
        ),
        Text(
          str,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),         
        )
      ],
    );
  }


}


