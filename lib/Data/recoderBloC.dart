// import 'dart:math';
// import 'package:MusicApp/Data/songModel.dart';
// import 'package:MusicApp/OnlineFeature/httpService.dart';
// import 'package:flute_music_player/flute_music_player.dart';
import 'package:MusicApp/OnlineFeature/UI/homePage.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecorderBloC{
  final LocalFileSystem localFileSystem = LocalFileSystem();
  bool isDispose = false;
  FlutterAudioRecorder _recorder;
  // BehaviorSubject<Duration> position;
  BehaviorSubject<Recording> _currRecord;
  RecordingStatus _currentStatus;
  File currentFile;
  
  Timer _t;
  bool wasUsed = false;
  int count = 0;

  BehaviorSubject<Recording> get currentRecord => _currRecord;

  RecorderBloC(){
    checkExistFile();
    initStream();
    initRecoder();
  }

  void initStream(){

    currentFile = null;
    _currRecord = BehaviorSubject<Recording>();

  }

  void initRecoder() async{
    try{
      print("Prepare Recorder");
      if (await FlutterAudioRecorder.hasPermissions) {

        String customPath = '/recorder';

        io.Directory appDocDirectory = await getExternalStorageDirectory(); // For android only
        customPath = appDocDirectory.path + customPath + " $count";
        count += 1;

        _recorder = FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;

        Recording result = await _recorder.current();
        //_currRecord = result;
        _currRecord.add(result);
      }
      print("Init Successfully");
    } catch (e){

      print("Fail to Init");

    }
  }

  void dispose(){
    try{
      isDispose = true;
      // print("Status: ${_currRecord.value.status}");
      if (_currRecord.value.status == RecordingStatus.Recording){    
        _recorder.stop();
      }
      //position.close();
      _currRecord.close();
      // _currentStatus.close();
    } catch(e){
      print("Fail to dispose");
    }

  }

  void checkExistFile() async {

    String customPath = '/recorder';

    io.Directory appDocDirectory;
    appDocDirectory = await getExternalStorageDirectory(); // For android only
    customPath = appDocDirectory.path + customPath;

    int _count = 0;
    while (count < 100){
      print("Path delete: ${customPath + " $_count" + ".wav"}");
      if (await io.File(customPath + " $_count" + ".wav").exists()) {
        // print("Delete in start");
        var dir = io.File(customPath + " $_count" + ".wav");
        dir.deleteSync(recursive: true);
      }
      else break;
      _count++;
    }


  }


  void start() async {

    try {
      print("Start Recorder");

      await _recorder.start();
      
      Recording current1 = await _recorder.current();

      //_currRecord = current;
      _currRecord.add(current1);

      _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {

        Recording current2 = await _recorder.current();
        //_currRecord = current2;
        _currRecord.add(current2);
        _t = t;
        if (_currRecord.value.duration == Duration(seconds: 3)){
          // print("After 3s");
          stop();
        }

      });
    } catch(e){
      print("Fail");
    }
  }

  void stop() async {
    print("Stop Recorder");
    var result = await _recorder.stop();
    _t.cancel();
    //_currRecord = result;
    _currRecord.add(result);
    currentFile = localFileSystem.file(_currRecord.value.path);
  }


}