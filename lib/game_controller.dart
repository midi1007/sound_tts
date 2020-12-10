import 'dart:io';


import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

void audioPlayerHandler(AudioPlayerState value) => print('state => $value');

class GameController {

  static AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  static AudioCache audioCache = AudioCache();



  static void play(String sound) {
    if (!kIsWeb && Platform.isIOS) {
      audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
      audioCache.disableLog();
    }
    audioCache.play(sound);
  }
}