import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/OfflineFeature/mp3Access.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/musicPlayer.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:MusicApp/musicPlayer.dart';

class CurrentPlayBar extends StatefulWidget {
  final Song currentSong;
  final Mp3Access fileData;
  CurrentPlayBar(this.fileData, this.currentSong);

  @override
  _CurrentPlayBarState createState() => _CurrentPlayBarState();
}

class _CurrentPlayBarState extends State<CurrentPlayBar> {
  @override
  Widget build(BuildContext context) {
    var currentSong = song;
    return GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) 
                    => MusicPlayer(widget.fileData, currentSong, nowPlaying: true,)
              )
          );
        },
        child: Container(
        color: ColorCustom.orange,
        height: 72,
        child: Row(
          children: <Widget>[
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
            SizedBox(width: 15),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 12),
                  Text(
                    //"Now Playing",
                    currentSong.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    currentSong.artist,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.75),
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}