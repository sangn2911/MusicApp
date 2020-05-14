import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/sizeConfig.dart';


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 31),
            child: text("Recently Play"),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 31),
            height: 170,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index){
                return musicPresentation(IconCustom.album_1, "Song $index", "Artist $index");
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 31),
            child: text("Favorite albums and songs"),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 31),
            height: 170,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index){
                return musicPresentation(IconCustom.album_1, "Song $index", "Artist $index");
              },
            )
          ),
          Container(
            color: ColorCustom.orange,
            height: 70,
          ),
          buttonSet(),          
        ],
      ),
    );
  }

  Widget appBar(){
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
        onPressed: null),
      title: Text(
        "Home",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconCustom.settings_1), 
          onPressed: (){}
        ),
      ],
    );
  }

  Widget text(String str){
    return Text(
      str,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget musicPresentation(IconData icon, String title, String artist){
    return Container(
      width: 130,
      child: Wrap(
        direction: Axis.vertical,
        children: <Widget> [
          Icon(
            icon,
            size: 110,
            color: ColorCustom.orange,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            artist,
            style: TextStyle(
              color: ColorCustom.grey1,
              fontSize: 14.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ]
      ),
    );
  }

  Widget buttonSet(){
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonWidget(Icons.home, "Home",
              function: (){}
            ),
            SizedBox(width: 70),
            buttonWidget(Icons.search, "Search",
              function: (){}
            ),
            SizedBox(width: 70),
            buttonWidget(Icons.library_music, "Library",
              function: (){}
            ),
          ],
        )
      )
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

  // Widget recentlyList(){
  //   return Container(
  //     padding: EdgeInsets.only(left: 35),
  //     height: 150,
  //     color: Colors.black,
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Recently Play",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 20.0,
  //             fontFamily: 'Lato',
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         ListView(
  //           scrollDirection: Axis.horizontal,
  //           children: <Widget>[
  //             Container(
  //               width: 110,
  //               child: Card(
  //                 color: Colors.black,
  //                 child: Column(
  //                   children: <Widget>[
  //                     Icon(
  //                       IconCustom.album_1,
  //                       size: 110,
  //                       color: ColorCustom.orange,
  //                     ),
  //                     Text(
  //                       "Song 1",
  //                       //song.title,
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 12,
  //                         fontFamily: 'Lato',
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     Text(
  //                       "Singer 1",
  //                       //song.artist,
  //                       style: TextStyle(
  //                         color: ColorCustom.grey1,
  //                         fontSize: 14.0,
  //                         fontFamily: 'Lato',
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget favoriteList(){
  //   return Container(
  //     padding: EdgeInsets.only(left: 35),
  //     height: 150,
  //     color: Colors.black,
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Favorite albums and songs",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 20.0,
  //             fontFamily: 'Lato',
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         ListView(
  //           scrollDirection: Axis.horizontal,
  //           children: <Widget>[
  //             Container(
  //               width: 110,
  //               child: Card(
  //                 color: Colors.black,
  //                 child: Column(
  //                   children: <Widget>[
  //                     Icon(
  //                       IconCustom.album_1,
  //                       size: 110,
  //                       color: ColorCustom.orange,
  //                     ),
  //                     Text(
  //                       "Song 1",
  //                       //song.title,
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 12,
  //                         fontFamily: 'Lato',
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     Text(
  //                       "Singer 1",
  //                       //song.artist,
  //                       style: TextStyle(
  //                         color: ColorCustom.grey1,
  //                         fontSize: 14.0,
  //                         fontFamily: 'Lato',
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }


}


