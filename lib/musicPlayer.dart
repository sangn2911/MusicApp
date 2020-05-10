import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/OfflineFeature/mp3Access.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:flute_music_player/flute_music_player.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'sizeConfig.dart';
//import 'main.dart';

enum PlayerState { stopped, playing, paused }

class MusicPlayer extends StatefulWidget {
  final Mp3Access fileData;
  final Song _song;
  final bool nowPlaying;
  MusicPlayer(this.fileData, this._song, {this.nowPlaying});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  // String song = "Beautiful In White";//Music.song;
  // String singer = "Westlife";//Music.singer;

  Song song;
  
//Package Music
  MusicFinder audioPlayer;
  Duration duration;
  Duration position;
  PlayerState playerState;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';
    
  bool isMuted = false;

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    play(widget.fileData.nextSong);
  }

  initPlayer() async {
    if (audioPlayer == null) {
      audioPlayer = widget.fileData.audioPlayer;
    }
    setState(() {
      song = widget._song;
      if (widget.nowPlaying == null || widget.nowPlaying == false)
        if (playerState != PlayerState.stopped) 
          stop();
      play(song);
    });
    
    audioPlayer.setDurationHandler((d) => 
      setState(() {
        duration = d;
      }));

    audioPlayer.setPositionHandler((p) => 
      setState(() {
          position = p;
      }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play(Song s) async {
    if (s != null) {
      final result = await audioPlayer.play(s.uri, isLocal: true);
      if (result == 1)
        setState(() {
          playerState = PlayerState.playing;
          song = s;
        });
    }
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        position = new Duration();
      });
  }

//--------------------------------
  Song file;

  double value = 0.0; // Track current music
  bool pauseState = true;

// Button play
  Icon iconPlay = Icon(
    Icons.play_circle_filled,
    color: Colors.white,
  );
// Button pause
  Icon iconPause = Icon(
    Icons.pause_circle_filled,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            Navigator.pop(context);
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
              song.title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            Text(
              song.artist,
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
              icon: pauseState ? iconPlay : iconPause,
              onPressed: () {
                setState(() {
                  pauseState = pauseState ? false : true;
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
              onPressed: (){
                print("Repeat");
              }
            ),

          ],
        ),
      ],
    );
  }
}
