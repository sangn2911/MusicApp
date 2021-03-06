import 'package:MusicApp/BloC/globalBloC.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/BloC/musicplayerBloC.dart';
import 'package:MusicApp/Feature/currentPlaying.dart';
import 'package:MusicApp/Feature/musicPlayer.dart';
import 'package:MusicApp/OnlineFeature/UI/userProfile.dart';
import 'package:MusicApp/Custom/sizeConfig.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Downloadlist extends StatefulWidget {
  final bool _isOnline;
  //final UserModel userInfo;
  Downloadlist(this._isOnline);

  @override
  DownloadlistState createState() => DownloadlistState();
}

class DownloadlistState extends State<Downloadlist> {

  List<dynamic> _filterList = List();
  List<dynamic> _songList = List();
  String _filterkey = "";

  bool isUsed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              searchBar(),
              SizedBox(height: SizeConfig.screenHeight*7/640),
              shuffleButton(),
              SizedBox(height: SizeConfig.screenHeight*7/640),
              musicList(),
              widget._isOnline
                ? onlineHandle()
                : offlineHandle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget onlineHandle(){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    final MusicPlayerBloC mpBloC = globalBloC.mpBloC;
    return StreamBuilder<bool>(
      stream: mpBloC.isUsed,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if (!snapshot.hasData){
          return Container();
        }
        return !snapshot.data
          ? Container(height: 70)
          : Container(height: 135);
      },
    );
  }

  Widget offlineHandle(){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    return isUsed
    ? GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayer(globalBloC)
              )
          );
        },
        child: CurrentPlayBar(globalBloC)
      ) 
    : Container();
  }


  Widget userButton(BuildContext context){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    //final MusicPlayerBloC mp = globalBloC.mpBloC;
    return IconButton(
      iconSize: 30,
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Icon(
          Icons.person,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile(globalBloC))
        );
      }
    );
  }

  Widget appBar(BuildContext context){
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: !widget._isOnline ? BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ) : userButton(context),
      title: Text(
        "Downloaded Songs",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      // actions: <Widget>[
      //   IconButton(icon: Icon(IconCustom.settings_1), onPressed: (){}),
      // ],
    );
  }

  Widget shuffleButton(){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    final MusicPlayerBloC mpBloC = globalBloC.mpBloC;
    return ButtonTheme(
      height: 31,
      minWidth: 158,
      buttonColor: ColorCustom.orange,
      child: RaisedButton(
        onPressed: ((){
          setState(() {
            isUsed = true;
          });
          mpBloC.stop();
          mpBloC.isUsed.add(true);
          mpBloC.playMode(2);
          mpBloC.updatePlaylist(mpBloC.songList.value);
          mpBloC.playRandomSong();
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black)
        ),
        child: Text(
          "Shuffle Play",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget searchBar(){
    return Padding(
      padding: EdgeInsets.only(left: 32,right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
          color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 9.0),
// Search Icon
            Icon(
              Icons.search,
              color: ColorCustom.orange,
              size: 25,
            ),

            SizedBox(width: 20),
// Text Input Field
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18),
//Hint text for textfield
                decoration: InputDecoration(
                  hintText: 'Songs, albums, artists',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                    letterSpacing: 0,
                  ),
                border: InputBorder.none,
                ),
//Function for textfield
              onChanged: (string){
                setState(() {
                  _filterkey = string;
                });
              },
              showCursor: true,
              cursorColor: Colors.black,
              )
            ),
            SizedBox(width: 49),
//-----------------------------------------------------------
          ],
        ),
      ),
    );
  }

  Widget empTylist(){
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 85,),
            Text(
              "Song Is Not Found",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      )
      );
  }

  Widget musicList(){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    final MusicPlayerBloC mpBloC = globalBloC.mpBloC;
    return StreamBuilder<List<Song>>(
      stream: mpBloC.songList,
      builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot){
        if (mpBloC.isDispose) return Container();
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }

        _songList = snapshot.data;
        if (_songList.length == 0) {
          return empTylist();
        }

        _filterList = _songList.where((element) => 
          (element.title.toLowerCase().contains(_filterkey.toLowerCase()) || 
          element.artist.toLowerCase().contains(_filterkey.toLowerCase())))
          .toList();

        return Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _filterList.length,
            itemBuilder: (BuildContext context, int index){
              Song _song = _filterList[index];
              return songTile(_song, _songList);
            },                                     
          ),
        );
      },

    );
  }

  Widget musicIcon(){
    return Container(
      height: 51,
      width: 47,
      decoration: BoxDecoration(
        color: ColorCustom.orange,
        border: Border.all(
        color: Colors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Icon(
        Icons.music_note,
        color: Colors.black,
        size: 45,
      ),
    );
  }

  Widget musicArt(Song song) {
    return musicIcon();
    // try {
    //   Widget icon = Container(
    //     height: 50,
    //     width: 50,
    //     child: FadeInImage(
    //       fit: BoxFit.fill,
    //       placeholder: AssetImage(song.albumArt), 
    //       image: AssetImage(song.albumArt),
    //     )
    //   );
    //   return icon;
    // } catch(e) {
    //   return musicIcon();
    // }
  }

  Widget songTile(Song song, List<Song> songList){
    final GlobalBloC globalBloC = Provider.of<GlobalBloC>(context);
    final MusicPlayerBloC mpBloC = globalBloC.mpBloC;
    return ListTile(
      leading: song.albumArt == null ? musicIcon() : musicArt(song),
      title: Text(
        song.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        song.artist,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorCustom.grey1,
          fontSize: 14.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
      ),
      //trailing: moreSetting(),
      onTap: () {
        setState(() {
          isUsed = true;
        });
        mpBloC.isUsed.add(true);
        mpBloC.updatePlaylist(songList);
        mpBloC.stop();
        mpBloC.handleSong(song);
        
      },
    );
  }




}