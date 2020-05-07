import 'package:MusicApp/color.dart';
import 'package:flutter/material.dart';
import 'customIcons.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'sizeConfig.dart';
//import 'main.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  String song = "Beautiful In White";//Music.song;
  String singer = "Westlife";//Music.singer;
  double value = 0.0; // Track current music
  bool pause = true;
// Button play (temporary)
  Icon icon1 = Icon(
    Icons.play_circle_filled,
    color: Colors.white,
  );
// Button pause
  Icon icon2 = Icon(
    Icons.pause_circle_filled,
    color: Colors.white,
  );
// Button play
  Icon icon3 = Icon(
    Icons.play_circle_filled,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            print("Dropdown Button");
            // Navigator.pop(context);
          },
        ),
      ),
      body: body()
    );
  }

  Widget body(){
    return Center(
      child: Column(
          children: <Widget>[
//--Wallpaper
            SizedBox(height: SizeConfig.screenHeight*28/640),
            imageDecoration(),
            SizedBox(height: SizeConfig.screenHeight*28/640),
            Text(
              song,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            Text(
              singer,
              style: TextStyle(
                color: ColorCustom.grey1,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 19,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight*20/640),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 28,
                  ), 
                  onPressed: (){
                    print("Favorite Button");
                    }
                  ),
                SizedBox(width: SizeConfig.screenWidth*200/360),
                IconButton(
                  icon: Icon(
                    IconCustom.playlist,
                    color: Colors.white,
                    size: 25,
                  ), 
                  onPressed: (){
                    print("Playlist button");
                    }
                  ),
              ]
            ),
            musicControl(),
            
//---------------------------------------------------
          ],
        ),
    );
  }

  Widget imageDecoration(){
    // return SvgPicture.asset(
    //   "images/album_1.svg", 
    //   color: ColorCustom.orange,
    // );
    return Icon(
      IconCustom.album_1,
      size: 185,
      color: ColorCustom.orange,
      );
  }

  Widget musicControl(){
    return Column(
      children: <Widget>[
//Button Sets
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Slider(
            value: value,
            onChanged: (double newvalue) {
              setState(() {
                value = newvalue;
              });
            },
            activeColor: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 28,
              icon: Icon(
                IconCustom.shuffle,
                color: Colors.white,
              ), 
              onPressed: null
              ),
            SizedBox(width: 10),
// Button "Back Music"
            IconButton(
              iconSize: 54.0,
              icon: Icon(
                Icons.skip_previous,
                color: Colors.grey,
              ),
              onPressed: () {}),
// Button "Pause/Play"
            IconButton(
              iconSize: 68.0,
              icon: pause ? icon3 : icon2,
              onPressed: () {
                setState(() {
                  pause = pause ? false : true;
                  print(pause ? "Pause" : "Play");
                });
              }),
// Button "Next Music"
            IconButton(
              iconSize: 54.0,
              icon: Icon(
                Icons.skip_next,
                color: Colors.grey,
              ),
              onPressed: () {}),
            SizedBox(width: 10),
// Button "repeat"
            IconButton(
              iconSize: 28,
              icon: Icon(
                IconCustom.repeat,
                color: Colors.white,
              ), 
              onPressed: null
              ),

          ],
        ),
      ],
    );
  }
}
