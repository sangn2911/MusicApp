import 'package:MusicApp/Data/mpControlBloC.dart';

import 'package:MusicApp/Feature/currentPlaying.dart';
import 'package:MusicApp/Feature/downloadlist.dart';

import 'package:MusicApp/Feature/musicPlayer.dart';
import 'package:MusicApp/OnlineFeature/UI/homePage.dart';
import 'package:MusicApp/OnlineFeature/UI/searchPage.dart';
// import 'package:MusicApp/OnlineFeature/UI/userProfile.dart';
// import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
// import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/sizeConfig.dart';
import 'package:provider/provider.dart';
// import 'package:MusicApp/OnlineFeature/UI/purchase.dart';
import 'package:MusicApp/Custom/custemText.dart';


class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> with SingleTickerProviderStateMixin{

  // AnimationController _controller;
  // Animation<double> _animation;
  int _currentIndex = 0;

  List<Widget> _children =[
    HomePage(),
    SearchPage(),
    SafeArea(child: Scaffold(body: Container(child: Center(child: Text("UpcomingPage")),))),
    Downloadlist(true),
  ];  

  void onNavigationBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final MpControllerBloC mp = Provider.of<MpControllerBloC>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 850),
            transitionBuilder: (Widget child, Animation<double> animation){ 
              return SlideTransition(
                  position: Tween<Offset>(begin: Offset(1,0), end: Offset(0, 0)).animate(animation),
                  child: child,
                );
              },
            child: _children[_currentIndex],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget> [
                currentPlaying(mp),
                bottomNavigator(),
              ]
            )
          ),
        ],
      ),
    );
  }

  Widget currentPlaying(MpControllerBloC mp){
    return StreamBuilder<bool>(
      stream: mp.isUsed,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if (!snapshot.hasData){
          return Container();
        }
        return !snapshot.data
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
      },
    );
  }

  Widget bottomNavigator(){
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 15,
        unselectedFontSize: 12,
        selectedItemColor: ColorCustom.orange,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(size: 35),
        unselectedIconTheme: IconThemeData(size: 30),
        onTap: onNavigationBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: textLato("Home", FontWeight.w700),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title: textLato("Search", FontWeight.w700),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
            ),
            title: textLato("Library", FontWeight.w700),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download,
            ),
            title: textLato("Downloaded", FontWeight.w700),
          )
        ] 
      ),
    );
  }

  Widget buttonWidget(IconData icon, String str, {void Function() function}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 2),
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

  Widget textLato(String str, FontWeight fontWeight){
    return Text(
      str,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Lato',
        fontWeight: fontWeight,
      ),
    );
  }

}