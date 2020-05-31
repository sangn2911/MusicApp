import 'package:MusicApp/Feature/mp3Access.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/ParentWidget.dart';
import 'package:MusicApp/OnlineFeature/login.dart';


class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  Mp3Access fileData;
  bool _isLoading = true;
  //QueryData;

@override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    _isLoading = true;

    var songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print("Failed to get songs: '${e.message}'.");
    }

    //print(songs);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return; // only can setState() when mounted == true

    setState(() {
      fileData = Mp3Access((songs));
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return ParentdWidget(fileData, _isLoading, Login());
  }
}