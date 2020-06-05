import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Feature/currentPlaying.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:MusicApp/sizeConfig.dart';
//import 'package:provider/provider.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayer extends StatefulWidget {
  final MpControllerBloC _mp;
  MusicPlayer(this._mp);

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {

//Temp--------------------------------


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

  Widget dropDownButton (){
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.arrow_drop_down,
        size: 35,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
        centerTitle: true,
        leading: IconButton(
          icon: dropDownButton(),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: Text(
          "Music Player",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: body()
    );
  }

  Widget body(){
    final MpControllerBloC mp = widget._mp;
    return Center(
      child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight*28/640),
            albumArtCover(mp),
            SizedBox(height: SizeConfig.screenHeight*28/640),
            songInfo(mp),
            SizedBox(height: SizeConfig.screenHeight*20/640),
            favoritePlayListButton(),
            musicControl(mp),
          ],
        ),
    );
  }

  Widget imageDecoration(){
    return Icon(
      IconCustom.album_1,
      size: 200,
      color: ColorCustom.orange,
    );
  }

  Widget albumArtCover(MpControllerBloC mp){
    // final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    // final MpControllerBloC mp = widget._mp;
    return Container(
      child: StreamBuilder<Song>(
        stream: mp.currentSong,
        builder: (BuildContext context, AsyncSnapshot<Song> snapshot){
          if (!snapshot.hasData){
            return  CircularProgressIndicator();
          }
          if (snapshot.data.albumArt == null){
            return  imageDecoration();
          }
          final currSong = snapshot.data;
          return Container(
            height: 200,
            width: 200,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(
                currSong.albumArt,
              )
            ),
          );
        }
      )
    );
  }

  Widget songInfo(MpControllerBloC mp){
    //final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    // final MpControllerBloC mp = widget._mp;
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: StreamBuilder<Song>(
        stream: mp.currentSong,
        builder: (BuildContext context, AsyncSnapshot<Song> snapshot){
          if (!snapshot.hasData){
            return Container();
          } 
          Song currentSong = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                text(currentSong.title, true ,Colors.white, 25, FontWeight.w700),
                text(currentSong.artist, true , ColorCustom.grey1, 19, FontWeight.w400),
            ],
          );
        },
      )
    );
  }

  Widget favoritePlayListButton(){
    return Row(                                                              //Playlist and RateButton
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
    );
  }

  Widget musicControl(MpControllerBloC mp){
    return Column(
      children: <Widget>[
        musicSlider(mp),
        controlButton(mp),
      ],
    );
  }

  Widget musicSlider(MpControllerBloC mp){
    // final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    // final MpControllerBloC mp = widget._mp;
    return Container(
      width: 360,
      child: StreamBuilder<MapEntry<Duration,Song>>(
        stream: CombineLatestStream.combine2(mp.position, mp.currentSong, (a,b) => MapEntry(a,b)),
        builder: (BuildContext context, AsyncSnapshot<MapEntry<Duration,Song>> snapshot){
          if (!snapshot.hasData){
            return Slider(value: 0, onChanged: null, activeColor: Colors.white,);
          }
          if (snapshot.data == null){
            return Slider(value: 0, onChanged: null, activeColor: Colors.white,);
          }

          final Duration dataPos = snapshot.data.key;
          final int positioninMilliseconds = dataPos.inMilliseconds;
          final Song currentSong = snapshot.data.value;
          final int durationinMilliseconds = currentSong.duration;
          return Column(
            children: <Widget>[
              Slider(
                min: 0.0,
                max: durationinMilliseconds.toDouble(),
                value: durationinMilliseconds > positioninMilliseconds 
                  ? positioninMilliseconds.toDouble()
                  : durationinMilliseconds.toDouble(),
                onChanged: (double value) {
                  final Duration newPos = Duration(
                    milliseconds: value.toInt(),
                  );
                  mp.updatePosition(newPos);
                },
                onChangeEnd: (double value) {
                  mp.audioSeek(value / 1000);
                },
                activeColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  text(dataPos.toString().split('.').first,false ,Colors.white, 15, FontWeight.w200),
                  SizedBox(width: 200),
                  text(mp.duration.toString().split('.').first,false ,Colors.white, 15, FontWeight.w200),
                ]
              )
            ],
          );
        },
      ),
    );
  }

  Widget controlButton(MpControllerBloC mp){
    //final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    //final MpControllerBloC mp = widget._mp;
    return Container(
      child: StreamBuilder<MapEntry<MapEntry<PlayerState,PlayerMode>,Song>>(
        stream: CombineLatestStream.combine3(mp.playerState, mp.playerMode,mp.currentSong, (a,b, c) => MapEntry(MapEntry(a,b),c)),
        builder: (BuildContext context, AsyncSnapshot<MapEntry<MapEntry<PlayerState,PlayerMode>,Song>> snapshot){
          if (!snapshot.hasData){
            return Container();
          }

          final Song currentSong = snapshot.data.value;
          final PlayerState playerState = snapshot.data.key.key;
          final PlayerMode playerMode = snapshot.data.key.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 28,
                icon: Icon(
                  IconCustom.shuffle,
                  color: (playerMode == PlayerMode.shuffle) 
                    ? ColorCustom.orange 
                    : Colors.white,
                ), 
                onPressed: (){
                  mp.playMode(2);
                }
              ),
              SizedBox(width: 10),
  // Button "Back Music"
              IconButton(
                iconSize: 54.0,
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.grey,
                ),
                onPressed: () => mp.prev()
              ),
  // Button "Pause/Play"
              IconButton(
                iconSize: 68.0,
                icon: (playerState != PlayerState.paused) 
                  ? iconPause 
                  : iconPlay,
                onPressed: (playerState != PlayerState.paused) 
                  ? () {
                    mp.pause();
                  }
                  : () {
                    mp.play(currentSong);
                    }
                ),
  // Button "Next Music"
              IconButton(
                iconSize: 54.0,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.grey,
                ),
                onPressed: () => mp.next()
                ),
              SizedBox(width: 10),
  // Button "repeat"
              IconButton(
                iconSize: 28,
                icon: Icon(
                  IconCustom.repeat,
                  color: (playerMode == PlayerMode.repeat) 
                    ? ColorCustom.orange 
                    : Colors.white,
                ), 
                onPressed: (){
                  setState(() {
                    mp.playMode(1);
                  });
                }
              ),
            ],
          );
        }
      ),
    );
  }

  Widget text(String str,bool isHide ,Color color , double size, FontWeight fontweight){
    return Text(
      str,
      overflow: isHide ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lato',
        fontWeight: fontweight,
      ),
    );
  }

}
