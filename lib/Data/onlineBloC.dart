import 'package:music_player/music_player.dart';
import 'package:rxdart/rxdart.dart';

class OnlineBloC{
  MusicPlayer audioOnline;
  BehaviorSubject<MusicItem> song;

  OnlineBloC(){
    audioOnline = new MusicPlayer();
  }

  void fetchSong(String id){
    
  }

  void play(){
    audioOnline.play(song.value);
    
  }


}