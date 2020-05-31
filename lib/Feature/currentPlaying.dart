import 'package:MusicApp/Custom/color.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Feature/musicPlayer.dart';
import 'package:MusicApp/ParentWidget.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';

bool isPlay = false;

class CurrentPlayBar extends StatefulWidget {

  @override
  CurrentPlayBarState createState() => CurrentPlayBarState();
}

class CurrentPlayBarState extends State<CurrentPlayBar> {

  

  @override
  Widget build(BuildContext context) {
    final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    return Container(
      color: ColorCustom.orange,
      height: 70,
      child: StreamBuilder<Song>(
        stream: mp.currentSong,
        builder: (BuildContext context, AsyncSnapshot<Song> snapshot){
          if (!snapshot.hasData) {
            return Container();
          }
          Song currentSong = snapshot.data;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 5),
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: ColorCustom.orange,
                  border: Border.all(
                  color: Colors.black,
                  ),
                ),
                child: Icon(
                  Icons.music_note,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 65,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(currentSong.title, Colors.black, 22, FontWeight.w700),
                    text(currentSong.artist, Colors.black.withOpacity(0.75), 18, FontWeight.w400),
                  ]
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 50,
                icon: Icon(
                  !isPlay ? Icons.play_arrow : Icons.pause,
                  color: Colors.black,
                  size: 50,
                ), 
                onPressed: (){
                  if(currentSong.title != " "){
                    setState(() {
                      isPlay ? isPlay = false : isPlay = true;
                    });
                    !isPlay ? mp.pause() : mp.play(currentSong);
                  }
                }
              ),
              SizedBox(width: 15),
              IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 50,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.black,
                  size: 50,
                ), 
                onPressed: () {
                  setState(() {
                    isPlay = true;
                  });
                  mp.next();
                }
               ),
            ],
          );
        },
      ),
    );
  }

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

}