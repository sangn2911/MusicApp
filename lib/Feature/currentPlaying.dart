import 'package:MusicApp/Custom/color.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';
import 'package:MusicApp/Custom/custemText.dart';
import 'package:rxdart/rxdart.dart';

class CurrentPlayBar extends StatefulWidget {

  @override
  CurrentPlayBarState createState() => CurrentPlayBarState();
}

class CurrentPlayBarState extends State<CurrentPlayBar> {

  @override
  Widget build(BuildContext context) {
    final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    return Container(
      decoration: BoxDecoration(
        color: ColorCustom.orange,
        border: Border.all(color: ColorCustom.orange),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
          bottom: Radius.circular(40),
        )
      ),
      height: 70,
      child: StreamBuilder<MapEntry<PlayerState,Song>>(
        stream: CombineLatestStream.combine2(mp.playerState, mp.currentSong, (a, b) => MapEntry(a,b)),
        builder: (BuildContext context, AsyncSnapshot<MapEntry<PlayerState,Song>> snapshot){
          if (!snapshot.hasData) {
            return Container();
          }
          Song currentSong = snapshot.data.value;
          PlayerState playerState = snapshot.data.key;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10,),
              playIconButton(currentSong, mp, playerState),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextLato(currentSong.title, Colors.black, 22, FontWeight.w700),
                      TextLato(currentSong.artist, Colors.black.withOpacity(0.75), 18, FontWeight.w400),
                    ]
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 33,
                icon: Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 35,
                ), 
                onPressed: () {
                  //mp.prev();
                }
               ),
              SizedBox(width: 7),
              IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 50,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.black,
                  size: 50,
                ), 
                onPressed: () {
                  mp.next();
                }
               ),
              SizedBox(width: 10),
            ],
          );
        },
      ),
    );
  }

  Widget playIconButton(Song currentSong, MpControllerBloC mp,PlayerState playerState){
    return IconButton(
      padding: EdgeInsets.all(0),
      iconSize: 60,
      icon: Icon(
        playerState == PlayerState.paused ? Icons.play_circle_outline : Icons.pause_circle_outline,
        color: Colors.black,
        size: 60,
      ), 
      onPressed: (){
        playerState != PlayerState.paused ? mp.pause() : mp.play(currentSong);
      }
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