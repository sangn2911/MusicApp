import 'package:MusicApp/myMusic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:MusicApp/musicApp.dart';
// import 'package:MusicApp/OnlineFeature/signUp.dart';
// import 'musicPlayer.dart';
// import 'package:MusicApp/OfflineFeature/downloadlist.dart';
import 'package:MusicApp/OnlineFeature/login.dart';
// import 'package:MusicApp/OnlineFeature/httpTest.dart';
// import 'package:MusicApp/OnlineFeature/homePage.dart';
// import 'package:MusicApp/OnlineFeature/userProfile.dart';
//import 'package:provider/provider.dart';
import 'package:MusicApp/Data/mpControlBloC.dart';
import 'package:MusicApp/OnlineFeature/purchase.dart';

class Music {
  static String song;
  static String singer;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final MpControllerBloC mpBloC = MpControllerBloC();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        //'/': (context) => MusicApp(),
        //'/': (context) => GoOffline(),
        '/': (context) => GoOnline(),
        'purchase': (context) => Purchase(),
        // 'downloadlist': (context) => Downloadlist(),
        // 'musicplayer': (context) => MusicPlayer(),
        'login': (context) => Login(),
        // 'signup': (context) => SignUp(),
        // 'testhttp':  (context) => MyAppTest(),
        // 'homepage':  (context) => HomePage(),
        // 'userprofile': (context) => UserProfile(),
      },
    );
    // return Provider<MpControllerBloC>(
    //   create: (BuildContext context){
    //     mpBloC.fetchSongs();
    //     return mpBloC;
    //   },
    //   dispose: (BuildContext context, MpControllerBloC mp) => mp.dispose(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     initialRoute: 'login',
    //     routes: {
    //       //'/': (context) => MusicApp(),
    //       '/': (context) => GoOffline(),
    //       // 'downloadlist': (context) => Downloadlist(),
    //       // 'musicplayer': (context) => MusicPlayer(),
    //       'login': (context) => Login(),
    //       // 'signup': (context) => SignUp(),
    //       // 'testhttp':  (context) => MyAppTest(),
    //       // 'homepage':  (context) => HomePage(),
    //       // 'userprofile': (context) => UserProfile(),
    //     },
    //   )
    // );

  }
}

