import 'package:flute_music_player/flute_music_player.dart';

class Mp3Access{
  List<Song> _songs;
  int _currentSongIndex = -1;
  MusicFinder musicFinder;
  Mp3Access(this._songs) {
    musicFinder = new MusicFinder();
  }

}