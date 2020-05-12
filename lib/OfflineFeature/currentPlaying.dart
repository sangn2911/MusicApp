import 'package:MusicApp/Custom/color.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/musicPlayer.dart';
import 'package:MusicApp/ParentWidget.dart';

class CurrentPlayBar extends StatefulWidget {

  final ParentdWidget rootIW;
  CurrentPlayBar(this.rootIW);

  @override
  CurrentPlayBarState createState() => CurrentPlayBarState();
}

class CurrentPlayBarState extends State<CurrentPlayBar> {

  var currentSong;

  @override
  Widget build(BuildContext context) {
    currentSong = song;
    return GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) 
                    => MusicPlayer(widget.rootIW.fileData, currentSong, nowPlaying: true,)
              )
          ).then((value) {
              setState(() {
                currentSong = song;
              });
            });
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