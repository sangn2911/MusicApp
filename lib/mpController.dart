
import 'package:MusicApp/Feature/mp3Access.dart';
import 'package:flute_music_player/flute_music_player.dart';


enum PlayerState { stopped, playing, paused }
enum PlayerMode { shuffle, repeat, normal }

class MpController{

  final Mp3Access fileData;

  MpController(this.fileData){
    if (audioPlayer == null) {
      audioPlayer = fileData.audioPlayer;
    }
    
    audioPlayer.setDurationHandler((d) => 
      duration = d
    );

    audioPlayer.setPositionHandler((p) => 
      position = p
    );

    audioPlayer.setCompletionHandler(() {
      onComplete();
      position = duration;
    });

    audioPlayer.setErrorHandler((msg) {
      playerState = PlayerState.stopped;
      duration = new Duration(seconds: 0);
      position = new Duration(seconds: 0);
    });
  }

  MusicFinder audioPlayer;
  Duration duration;
  Duration position;
  PlayerState playerState;
  PlayerMode playerMode;
  Song song;

  get currentSong => song;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get isShuffle => playerMode == PlayerMode.shuffle;
  get isRepeat => playerMode == PlayerMode.repeat;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  set playMode(int mode){
    if (mode == 0)
      playerMode = PlayerMode.normal;
    else if (mode == 1)
      if (!isRepeat)
        playerMode = PlayerMode.repeat;
      else
        playerMode = PlayerMode.normal;
    else 
      if (!isShuffle)
        playerMode = PlayerMode.shuffle;
      else
        playerMode = PlayerMode.normal;
  }

  Future play(Song s) async {
    if (s != null) {
      final result = await audioPlayer.play(s.uri, isLocal: true);
      if (result == 1)
        playerState = PlayerState.playing;
        song = s;
    }

  }

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) playerState = PlayerState.paused;
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      playerState = PlayerState.stopped;
      position = new Duration();

  }

  Future next(Mp3Access f) async {
    stop();
    song = f.nextSong;
    play(song);

  }

  Future prev(Mp3Access f) async {
    stop();
    song = f.prevSong;
    play(song);

  }

  void onComplete() {
    playerState = PlayerState.stopped;
    if (isRepeat) 
      play(song);
    else if (isShuffle) {
      play(fileData.randomSong);   
    }
    else
      play(fileData.nextSong);
  }

}