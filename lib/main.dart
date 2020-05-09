import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'musicPlayer.dart';
import 'package:MusicApp/OfflineFeature/downloadlist.dart';
//import 'login.dart';

class Music {
  static String song;
  static String singer;
}

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled=false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/downloadlist',
      routes: {
        '/downloadlist': (context) => Downloadlist(),
        '/musicplayer': (context) => MusicPlayer(),
        // '/login': (context) => Login(),
      },
    );
  }
}

