import 'package:MusicApp/OnlineFeature/homePage.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';
import 'package:provider/provider.dart';
import 'package:MusicApp/Feature/downloadlist.dart';

class GoOffline extends StatelessWidget {

  final MpControllerBloC mpBloC = MpControllerBloC();

  @override
  Widget build(BuildContext context) {
    return Provider<MpControllerBloC>(
      create: (BuildContext context){
        mpBloC.fetchSongs();
        return mpBloC;
      },
      dispose: (BuildContext context, MpControllerBloC mp) => mp.dispose(),
      child: Downloadlist(),
    );
    //return Downloadlist();
  }
}

class GoOnline extends StatelessWidget {

  final MpControllerBloC mpBloC = MpControllerBloC();

  @override
  Widget build(BuildContext context) {
    return Provider<MpControllerBloC>(
      create: (BuildContext context){
        mpBloC.fetchSongs();
        return mpBloC;
      },
      dispose: (BuildContext context, MpControllerBloC mp) => mp.dispose(),
      child: HomePage(),
    );
    //return HomePage();
  }
}