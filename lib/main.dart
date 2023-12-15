import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/screens/start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //FlutterNativeSplash.removeAfter(initialization);

  await StatsPreferences.init();

  runApp(MyApp());
}
/*
Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}*/

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appState = MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: StartScreen(appState: appState),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  bool musicIsSelected = false;
  bool soundIsSelected = true;
  bool isMusicPlaying = false;
  final musicPath = "sounds/music.wav";
  final player = AudioPlayer();
  final cdPlayer = AudioPlayer();

  void playMusic() async {
    if (!isMusicPlaying) {
      await player.play(AssetSource(musicPath));
      player.onPlayerComplete.listen((event) {
        player.play(AssetSource(musicPath));
      });
      isMusicPlaying = true;
      player.setVolume(0.3);
      notifyListeners();
    }
  }

  void stopMusic() {
    if (isMusicPlaying) {
      player.stop();
      isMusicPlaying = false;
      notifyListeners();
    }
  }

  void pauseMusic() {
    player.pause();
    notifyListeners();
  }

  void pauseCd() {
    cdPlayer.pause();
    notifyListeners();
  }

  void resumeMusic() {
    player.resume();
    notifyListeners();
  }

  void resumeCd() {
    cdPlayer.resume();
    notifyListeners();
  }

  void playCountDown() async {
    if (soundIsSelected) {
      await cdPlayer.play(AssetSource('sounds/countdown.mp3'));
      cdPlayer.setVolume(0.2);
      notifyListeners();
    }
  }

  void stopCountDown() {
    cdPlayer.stop();
    notifyListeners();
  }
}
