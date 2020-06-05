import 'package:MusicApp/Custom/color.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:provider/provider.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';
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
      color: ColorCustom.orange,
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
              Expanded(
                child: Container(
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text(currentSong.title, Colors.black, 22, FontWeight.w700),
                      text(currentSong.artist, Colors.black.withOpacity(0.75), 18, FontWeight.w400),
                    ]
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 50,
                icon: Icon(
                  playerState == PlayerState.paused ? Icons.play_arrow : Icons.pause,
                  color: Colors.black,
                  size: 50,
                ), 
                onPressed: (){
                  if(currentSong.title != " "){
                    playerState != PlayerState.paused ? mp.pause() : mp.play(currentSong);
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