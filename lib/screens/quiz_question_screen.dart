import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/model/questions_model.dart';
import 'package:myapp/screens/menu-screen.dart';
import 'package:myapp/screens/menu_overlay.dart';
import 'package:myapp/screens/quiz_end_screen.dart';
import 'package:myapp/services/questions_service.dart';
import 'package:myapp/utils.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen(
      {super.key, required this.type, required this.appState});

  final String type;
  final MyAppState appState;

  @override
  State<StatefulWidget> createState() => QuizQuestionScreenState();
}

class QuizQuestionScreenState extends State<QuizQuestionScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  QuestionService questionService = QuestionService();

  late Future<Question> randomQuestion = Future<Question>.value(Question(
    id: 0,
    question: '',
    optionA: '',
    optionB: '',
    optionC: '',
    optionD: '',
    correctAnswer: '',
  ));

  @override
  void initState() {
    super.initState();
    randomQuestion = randQuestion();
    startTimer();
    widget.appState.playCountDown();
    WidgetsBinding.instance.addObserver(this);
  }

  late Timer _timer;
  int _start = 60;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            widget.appState.stopCountDown();
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizEndScreen(
                  rightAnswers: sumRightAns,
                  wrongAnswers: sumWrongAns,
                  appState: widget.appState,
                ),
              ),
            );
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.appState.stopCountDown();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.appState.pauseMusic();
      widget.appState.pauseCd();
    } else if (state == AppLifecycleState.resumed) {
      if (widget.appState.isMusicPlaying) {
        widget.appState.resumeMusic();
      }
      if (widget.appState.soundIsSelected) {
        widget.appState.resumeCd();
      }
    }
  }

  String selectType(String type) {
    if (type == 'Computers') {
      return FilePaths().computersPath;
    } else if (type == "Mathematics") {
      return FilePaths().mathematicsPath;
    } else if (type == "History") {
      return FilePaths().historyPath;
    } else if (type == "Animals") {
      return FilePaths().animalsPath;
    } else if (type == "Music") {
      return FilePaths().musicPath;
    } else if (type == "Vehicles") {
      return FilePaths().vehiclesPath;
    } else if (type == "Film") {
      return FilePaths().filmPath;
    } else if (type == "Television") {
      return FilePaths().televisionPath;
    }

    return '';
  }

  Future<Question> randQuestion() async {
    Question randomQuestion =
        await questionService.getRandomQuestion(selectType(widget.type));
    return randomQuestion;
  }

  void chanceQuestion() {
    setState(() {
      count++;
    });

    if (count == 9) {
      _timer.cancel();
      if (widget.appState.soundIsSelected) {
        widget.appState.stopCountDown();
        AudioPlayer().play(AssetSource(AudioPath().endSound));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizEndScreen(
            rightAnswers: sumRightAns,
            wrongAnswers: sumWrongAns,
            appState: widget.appState,
          ),
        ),
      );
    } else {
      setState(() {
        randomQuestion = randQuestion();
      });
    }
  }

  void buttonsOntab(var snapshot, String answers) {
    if (snapshot.data!.correctAnswer == answers) {
      if (widget.appState.soundIsSelected) {
        AudioPlayer().play(AssetSource(AudioPath().successSound));
      }
      setState(() {
        sumRightAns++;
      });
    } else {
      if (widget.appState.soundIsSelected) {
        AudioPlayer().play(AssetSource(AudioPath().wrongSound));
      }
      setState(() {
        sumWrongAns++;
      });
    }
    //Her soru değiştirmeden önce soru doğru ise ekrana ona göre bir işaret ver ve araya sorunun değişimi için araya delay koy
    chanceQuestion();
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  String convertSecondToMinute(int second) {
    int m = (second / 60).floor();
    int s = (second - (m * 60));
    return "$m:$s";
  }

  int sumRightAns = 0, sumWrongAns = 0, count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuOverlay(appState: widget.appState),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight, maxHeight: double.infinity),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfffff9e4),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 76,
                        color: const Color(0xffffffff),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                openDrawer();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Container(
                                width: 42,
                                height: 42,
                                child: Image.asset(
                                  'assets/page-1/images/menu-icon.png',
                                  width: 42,
                                  height: 42,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 43, top: 28, bottom: 11.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 4, 2),
                              width: 16,
                              height: 16,
                              child: Icon(
                                Icons.question_mark_sharp,
                                size: 16,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '0$count/08',
                                    style: SafeGoogleFont(
                                      'Cabinet Grotesk Variable',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2575,
                                      color: const Color(0xff151515),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Row(
                                      children: [
                                        Text(
                                          convertSecondToMinute(_start),
                                          style: SafeGoogleFont(
                                            'Cabinet Grotesk Variable',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575,
                                            color: const Color(0xff151515),
                                          ),
                                        ),
                                        Icon(Icons.access_time),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 43, right: 43),
                        child: Divider(
                          height: 1,
                          color: Colors.black,
                          thickness: 3,
                        ),
                      ),
                      FutureBuilder<Question>(
                        future: randomQuestion,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Hata: ${snapshot.error}');
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        51, 17, 51, 10),
                                    child: DefaultTextStyle(
                                      style: SafeGoogleFont(
                                        'Cabinet Grotesk Variable',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2575,
                                        color: const Color(0xff151515),
                                      ),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                              snapshot.data!.question)
                                        ],
                                        isRepeatingAnimation: false,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    buttonsOntab(snapshot, "A");
                                  },
                                  child: Container(
                                    width: 319,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff571530),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      // button6Da (I10:1625;34:24)
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      width: 311,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff561430)),
                                        color: const Color(0xfff03985),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data!.optionA,
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Cabinet Grotesk Variable',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575,
                                            color: const Color(0xff3d0e21),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextButton(
                                  onPressed: () {
                                    buttonsOntab(snapshot, "B");
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    width: 319,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff14441f),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      // button6Da (I10:1625;34:24)
                                      margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      width: 311,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff14441f)),
                                        color: const Color(0xff43dd64),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data!.optionB,
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Cabinet Grotesk Variable',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575,
                                            color: const Color(0xff0d2b13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextButton(
                                  onPressed: () {
                                    buttonsOntab(snapshot, "C");
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    width: 319,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff594a16),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      // button6Da (I10:1625;34:24)
                                      margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      width: 311,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff594a16)),
                                        color: const Color(0xfff2ca3b),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data!.optionC,
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Cabinet Grotesk Variable',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575,
                                            color: const Color(0xff3f350f),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextButton(
                                  onPressed: () {
                                    buttonsOntab(snapshot, "D");
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    width: 319,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff163959),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      // button6Da (I10:1625;34:24)
                                      margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      width: 311,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff163959)),
                                        color: const Color(0xff3b9af2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data!.optionD,
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Cabinet Grotesk Variable',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575,
                                            color: const Color(0xff0f283f),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        // optionaUBW (10:1839)
                        margin: EdgeInsets.fromLTRB(47, 0, 47, 0),
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xff571530),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          // buttonZCx (I10:1839;34:24)
                          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: TextButton(
                            onPressed: () {
                              if (widget.appState.soundIsSelected) {
                                AudioPlayer()
                                    .play(AssetSource(AudioPath().clickSound));
                              }
                              widget.appState.stopCountDown();
                              quitDialog();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 311,
                              height: 60,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff561430)),
                                color: const Color(0xfff03985),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Quit Quiz',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2575,
                                    color: const Color(0xfffff9e4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Future quitDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to exit?'),
            content: Text('Your actions will be lost!'),
            actions: [
              TextButton(
                onPressed: () {
                  _timer.cancel();
                  if (widget.appState.soundIsSelected) {
                    AudioPlayer().play(AssetSource(AudioPath().clickSound));
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuScreen(
                                appState: widget.appState,
                              )));
                },
                child: Text('Main Menu'),
              ),
              TextButton(
                onPressed: () {
                  if (widget.appState.soundIsSelected) {
                    AudioPlayer().play(AssetSource(AudioPath().clickSound));
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }
}
