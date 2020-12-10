
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';


enum TtsState { playing, stopped, paused, continued }

class Tts {


  FlutterTts flutterTts;
//  dynamic languages;
  String language = 'es-ES';
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.2;
  String voice = 'Jorge';//'Paulina',''

  double volumeIos = 1.0;
  double pitchIos = 1.0;
  double rateIos = 0.4;
  String voiceIos = 'Jorge';

  String voiceAndroid = 'Paulina';
  dynamic voices;
  dynamic languages;
  bool playRW = false;
  bool _right = false;

  List<String> voicesIos =[
    //spanish
    'Jorge',
    'Marisol',
    'Mónica',
    //mexican
    'Angelica',
    'Juan',
    'Paulina',

  ];


  getVoicesListIos(){
    return voiceIos;
  }

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    if (isAndroid) {
      _getEngines();
    }

    flutterTts.setStartHandler(() {

        print("Playing");
        ttsState = TtsState.playing;

    });

    flutterTts.setCompletionHandler(() {

        print("Complete");
        ttsState = TtsState.stopped;

    });

    flutterTts.setCancelHandler(() {

        print("Cancel");
        ttsState = TtsState.stopped;

    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {

          print("Paused");
          ttsState = TtsState.paused;

      });

      flutterTts.setContinueHandler(() {

          print("Continued");
          ttsState = TtsState.continued;

      });
    }

    flutterTts.setErrorHandler((msg) {

        print("error: $msg");
        ttsState = TtsState.stopped;

    });
  }


  setTextAndPlay(String text) async {


    int result = await _speak(text);
    if (result == 1) {
      ttsState = TtsState.playing;
    }


  }

  dispose(){
    flutterTts.stop();
  }

  getVoices(){
    _getVoices();
  }

  getLanguages(){
    _getLanguages();
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
//    if (languages != null) setState(() => languages);
  }

    Future _getVoices() async {
    voices = await flutterTts.getVoices;

//    if (languages != null) setState(() => languages);
  }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }


  Future<int> _speak(String text) async {
    await flutterTts.setLanguage(language);
    if(Platform.isIOS){
      await flutterTts.setVoice(voiceIos);
      await flutterTts.setVolume(volumeIos);
      await flutterTts.setSpeechRate(rateIos);
      await flutterTts.setPitch(pitchIos);

    }else if(Platform.isAndroid){
      await flutterTts.setVoice(voice);
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setPitch(pitch);
    }else{
      await flutterTts.setVoice(voice);
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setPitch(pitch);
    }



    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        return await flutterTts.speak(text);
      }
    }
  }

  Future<int> _stop() async {
    var result = await flutterTts.stop();
    return result;

  }

  Future<int> _pause() async {
    var result = await flutterTts.pause();
    return result;
  }

  void setVoiceIos(int i) {
    voiceIos = voicesIos[i];
  }

  void setSpeechRateIos(double value) {
    rateIos = value;
  }

  void setPitchRateIos(double value) {
    pitchIos = value;
  }


}


