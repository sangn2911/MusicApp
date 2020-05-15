import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:MusicApp/musicApp.dart';
// import 'package:MusicApp/OnlineFeature/signUp.dart';
// import 'musicPlayer.dart';
// import 'package:MusicApp/OfflineFeature/downloadlist.dart';
import 'package:MusicApp/OnlineFeature/login.dart';
// import 'package:MusicApp/OnlineFeature/httpTest.dart';
import 'package:MusicApp/OnlineFeature/homePage.dart';

class Music {
  static String song;
  static String singer;
}

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => MusicApp(),
        // '/downloadlist': (context) => Downloadlist(),
        // '/musicplayer': (context) => MusicPlayer(),
        '/login': (context) => Login(),
        // '/signup': (context) => SignUp(),
        // '/testhttp':  (context) => MyAppTest(),
        '/homepage':  (context) => HomePage(),
      },
    );
  }
}

