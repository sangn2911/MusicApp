import 'package:MusicApp/Data/mpControlBloC.dart';
import 'package:MusicApp/Feature/currentPlaying.dart';
import 'package:MusicApp/Feature/musicPlayer.dart';
import 'package:MusicApp/OnlineFeature/userProfile.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:MusicApp/OnlineFeature/purchase.dart';
import 'package:MusicApp/Custom/custemText.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isUsed = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0/640 * SizeConfig.screenHeight),
        child: appBar(context)
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      recentlyList(mp),
                      favouriteList(mp),
                      yourSongList(mp),
                    ]
                  ),
                ),
              ),
            ),
          ),
          currentPlaying(mp),        
        ],
      ),
      bottomNavigationBar: buttonSet(context),
    );
  }

  Widget appBar(BuildContext context){
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
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile())
          );
        }
      ),
      title: TextLato("Home", Colors.white ,20, FontWeight.w700),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconCustom.settings_1), 
          onPressed: (){}
        ),
      ],
    );
  }

  Widget currentPlaying(MpControllerBloC mp){
    return !isUsed
      ? Container()
      : GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayer(mp),
            )
          );
        },
        child: CurrentPlayBar()
      );
  }

  Widget recentlyList(MpControllerBloC mp){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
          child: TextLato("Recently Play", Colors.white, 20, FontWeight.w700),
        ),
        SizedBox(height: 10/640 * SizeConfig.screenHeight),
        Container(
          //padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
          height: 170/640 * SizeConfig.screenHeight,
          color: Colors.black,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index){
              return songTile(IconCustom.album_1, "Song $index", "Artist $index", true);
            },
          )
        ),
      ],
    );
  }

  Widget favouriteList(MpControllerBloC mp){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
          child: TextLato("Favorite albums and songs", Colors.white, 20, FontWeight.w700),
        ),
        SizedBox(height: 10/640 * SizeConfig.screenHeight),
        Container(
          //padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
          height: 170/640 * SizeConfig.screenHeight,
          color: Colors.black,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index){
              return songTile(IconCustom.album_1, "Song $index", "Artist $index", false);
            },
          )
        ),
      ],
    );
  }

  Widget yourSongList(MpControllerBloC mp){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TextLato("Your songs", Colors.white, 20, FontWeight.w700),
        ),
        SizedBox(height: 10/640 * SizeConfig.screenHeight),
        Container(
          //padding: EdgeInsets.only(left: 31/360 * SizeConfig.screenWidth),
          height: 170/640 * SizeConfig.screenHeight,
          color: Colors.black,
          child: StreamBuilder<List<Song>>(
            stream: mp.songList,
            builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot){
              if (mp.isDispose) return Container();
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
              List<Song> _songList = snapshot.data;
              // _filterList = _songList;
              if (_songList.length == 0) {
                return Container();
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _songList.length,
                itemBuilder: (BuildContext context, int index){
                  Song _song = _songList[index];
                  return songDownloaded(mp, IconCustom.album_1, _song);
                },
              );
            },
          )
        ),
      ],
    );
  }

  Widget songTile(IconData icon, String title, String artist, bool inPhone){
    return Container(
      width: 150/360 * SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          IconButton(
            padding: EdgeInsets.all(0),
            iconSize: 110/640 * SizeConfig.screenHeight,
            icon: Container(
              color: ColorCustom.orange,
              child: Icon(
                Icons.music_note,
                color: Colors.black,
              ),
            ),
            onPressed: (){
              print("Select song $title");
            },
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    TextLato(title, Colors.white, 20, FontWeight.w700),
                    TextLato(artist, ColorCustom.grey1, 14, FontWeight.w400),
                  ]
                ),
              ),
              SizedBox(width: 30/110 * (110/640 * SizeConfig.screenHeight)),
              inPhone ? Container() : purchaseButton(title),
            ]
          )
        ]
      ),
    );
  }

  Widget purchaseButton(String title){
    return SizedBox(
      height: 25/640 * SizeConfig.screenHeight,
      width: 25/640 * SizeConfig.screenHeight,
      child: IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
        size: 25/360 * SizeConfig.screenWidth,
        ), 
      onPressed: (){
        print("Buy $title");
      }),
    );
  }

  Widget songDownloaded(MpControllerBloC mp, IconData icon, Song song){
    String title = song.title;
    String artist = song.artist;
    return Container(
      width: 150/360 * SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          IconButton(
            padding: EdgeInsets.all(0),
            iconSize: 110/640 * SizeConfig.screenHeight,
            icon: Container(
              color: ColorCustom.orange,
              child: Icon(
                Icons.music_note,
                color: Colors.black,
              ),
            ),
            onPressed: (){
              setState(() {
                isUsed = true;
              });
              mp.stop();
              mp.play(song);
            },
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    TextLato(title, Colors.white, 20, FontWeight.w700),
                    TextLato(artist, ColorCustom.grey1, 14, FontWeight.w400),
                  ]
                ),
              ),
            ]
          )
        ]
      ),
    );
  }

  // Widget navigationBar(){
  //   return Container(
  //     decoration: BoxDecoration(

  //     ),
  //     child: BottomNavigationBar(
  //       currentIndex: _selectedIndex,
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home),
  //           title: TextLato("Home", Colors.black, 12, FontWeight.w700),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search),
  //           title: TextLato("Search", Colors.black, 12, FontWeight.w700),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.library_music),
  //           title: TextLato("Library", Colors.black, 12, FontWeight.w700),
  //         ),
  //       ],
  //       onTap: (index){
  //         setState(() {
  //           _selectedIndex = index;
  //         });
  //       },

  //     ),
  //   );
  // }


  Widget buttonSet(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      height: 55/640 * SizeConfig.screenHeight,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonWidget(Icons.home, "Home",
              function: (){}
            ),
            SizedBox(width: 55),
            buttonWidget(Icons.search, "Search",
              function: (){}
            ),
            SizedBox(width: 55),
            buttonWidget(Icons.library_music, "Library",
              function: (){}
            ),
            SizedBox(width: 55),
            buttonWidget(Icons.shopping_cart, "VIP",
              function: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Purchase(),
                    );
                  }
                );
              }
            ),
          ],
        )
      ),
    );
  }

  Widget buttonWidget(IconData icon, String str, {void Function() function}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 5),
        IconButton(
          padding: EdgeInsets.only(bottom: 0),
          iconSize: 40,
          icon: Icon(
            icon,
            color: Colors.black,    
          ),
          onPressed: function,
        ),
        TextLato(str, Colors.black, 12, FontWeight.w700),
      ],
    );
  }

}

