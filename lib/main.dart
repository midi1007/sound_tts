import 'package:flutter/material.dart';
import 'package:sound_tts/tts.dart';

import 'game_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Tts tts = Tts();


  void setTextAndSay(String text){
    tts.setTextAndPlay(text);
  }


  @override
  void initState() {
    tts.initTts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('sound'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.volume_down),
                    onPressed: (){
                      GameController.play('audio/allRight.wav');
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.volume_down_outlined),
                    onPressed: (){
                      GameController.play('audio/oneRight.wav');
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.volume_up),
                    onPressed: (){
                      GameController.play('audio/wrong.wav');
                    },
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Text('texttospeech'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  FloatingActionButton(
                    child: Icon(Icons.person_add_alt),
                    onPressed: (){
                      setTextAndSay('nosotros');
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.person_add_alt),
                    onPressed: (){
                      setTextAndSay('ellos');
                    },
                  ),

                ],
              ),

            ],
          ),


        ),
      );

  }
}
