import 'dart:math';
import 'package:MusicApp/OnlineFeature/httpTest.dart';
import 'package:MusicApp/mpController.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:rxdart/rxdart.dart';

enum PlayerState { stopped, playing, paused }
enum PlayerMode { shuffle, repeat, normal }

class MpControllerBloC{

//List management

  BehaviorSubject<List<Song>> _songs;
  List<Album> _albums;
  List<Song> _favorites;
  List<Song> _recently;
  List<Song> _currentPlayList;
  
//Music Player Controller

  MusicFinder _audioPlayer;
  Duration _duration;
  BehaviorSubject<Duration> _position;
  BehaviorSubject<PlayerState> _playerState;
  BehaviorSubject<PlayerMode> _playerMode; 
  BehaviorSubject<Song> _currentSong;
  BehaviorSubject<bool> _isAudioSeeking;

  BehaviorSubject<List<Song>> get songList => _songs;

  BehaviorSubject<Song> get currentSong => _currentSong;

  bool get isPlaying => _playerState.value == PlayerState.playing;
  bool get isPaused => _playerState.value == PlayerState.paused;

  bool get isShuffle => _playerMode.value == PlayerMode.shuffle;
  bool get isRepeat => _playerMode.value == PlayerMode.repeat;

  Duration get duration => _duration;

  BehaviorSubject<Duration> get position => _position;
  BehaviorSubject<PlayerState> get playerState => _playerState;
  BehaviorSubject<PlayerMode> get playerMode => _playerMode;

  Future<void> fetchSongs() async {
    print("Fectch Songs");
    await MusicFinder.allSongs()
      .then(
        (songs) => _songs.add(songs)
      );
  }

  MpControllerBloC(){
    _initStreams();
    _initAudioPlayer();
    _initCurrentSong();
  }

  void dispose(){
    stop();
    _songs.close();
    _favorites.clear();
    _playerState.close();
    _playerMode.close();
    _audioPlayer.stop();
  }

  void _initStreams(){
    _songs = BehaviorSubject<List<Song>>();
    _albums = List<Album>();
    _position = BehaviorSubject<Duration>();
    _favorites = [];
    _playerState = BehaviorSubject<PlayerState>.seeded(PlayerState.stopped);
    _playerMode = BehaviorSubject<PlayerMode>.seeded(PlayerMode.normal);
  }

  void _initCurrentSong() {
    Song initSong = Song(
      null,
      " ",
      " ",
      " ",
      null,
      null,
      null,
      null,
    );
    _currentSong = BehaviorSubject<Song>.seeded(initSong);
  }

  void _initAudioPlayer() {
    _audioPlayer = MusicFinder();

    _audioPlayer.setPositionHandler(
      (Duration position) {
        updatePosition(position);
      },
    );

    _audioPlayer.setDurationHandler(
      (Duration dur) {
        _duration = dur;
      },
    );

    _audioPlayer.setCompletionHandler(
      () {
        onComplete();
      },
    );

    _audioPlayer.setErrorHandler((msg) {
      _playerState.add(PlayerState.stopped);
      _duration = new Duration(seconds: 0);
      _position = BehaviorSubject<Duration>.seeded(Duration(seconds: 0));
    });
  }

  void playMode(int mode){
    if (mode == 0)
      _playerMode.add(PlayerMode.normal);
    else if (mode == 1)
      if (!isRepeat)
        _playerMode.add(PlayerMode.repeat);
      else
        _playerMode.add(PlayerMode.normal);
    else 
      if (!isShuffle)
        _playerMode.add(PlayerMode.shuffle);
      else
        _playerMode.add(PlayerMode.normal);
  }

  void updatePosition(Duration position) {
    _position.add(position);
  }

  void invertSeekingState() {
    final _value = _isAudioSeeking.value;
    _isAudioSeeking.add(!_value);
  }

  void audioSeek(double seconds) {
    _audioPlayer.seek(seconds);
  }

  play(Song song) {
    _currentSong.add(song);

    _audioPlayer.play(_currentSong.value.uri);

    _playerState.add(PlayerState.playing);
  }

  Future<void> pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) _playerState.add(PlayerState.paused);
  }

  Future<void> stop() async{
    final result = await _audioPlayer.stop();
    if (result == 1) {
      _playerState.add(PlayerState.stopped);
      _position.add(Duration(seconds: 0));
    }
  }

  Future<void> next() async {
    stop();

    List<Song> songs = _songs.value;
    int index = songs.indexOf(_currentSong.value);

    if (index + 1 == songs.length)
      _currentSong.add(songs[0]);
    else
      _currentSong.add(songs[index + 1]);
    play(_currentSong.value);
  }

  Future prev() async {
    stop();
    List<Song> songs = _songs.value;
    int index = songs.indexOf(_currentSong.value);
    if (index - 1 == -1)
      _currentSong.add(songs[songs.length - 1]);
    else
      _currentSong.add(songs[index - 1]);
    play(_currentSong.value);
  }

  void onComplete() {
    stop();
    
    if (isRepeat)
      play(_currentSong.value);
    else if (isShuffle) {
      playRandomSong();   
    }
    else
      next();
  }

  void playRandomSong(){
    Random r = new Random();
    List<Song> songs = _songs.value;
    int nextIndex = r.nextInt(songs.length);
    _currentSong.add(songs[nextIndex]);
    play(_currentSong.value);
  }


}