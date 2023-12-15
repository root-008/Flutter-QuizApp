import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/menu-screen.dart';
import 'package:myapp/screens/menu_overlay.dart';
import 'package:myapp/utils.dart';

// ignore: must_be_immutable
class QuizEndScreen extends StatelessWidget {
  int rightAnswers, wrongAnswers;

  QuizEndScreen(
      {super.key,
      required this.rightAnswers,
      required this.wrongAnswers,
      required this.appState});

  final MyAppState appState;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var padding = MediaQuery.of(context).padding;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MenuOverlay(appState: appState),
        body: SizedBox(
          width: double.infinity,
          child: Container(
            // quizzendscreenywi (10:1691)
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xfffff9e4),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 76,
                      color: const Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () {
                              if (appState.soundIsSelected) {
                                AudioPlayer()
                                    .play(AssetSource(AudioPath().clickSound));
                              }
                              openDrawer();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: SizedBox(
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
                  ),
                  const Flexible(
                    flex: 1,
                    child: Divider(
                      height: 1,
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 27, bottom: 10),
                      child: Text(
                        'Time Out!!!',
                        style: SafeGoogleFont(
                          'Cabinet Grotesk Variable',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.2575,
                          color: const Color(0xff151515),
                        ),
                      ),
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 43, right: 43),
                      child: Divider(
                        height: 2,
                        color: Colors.black,
                        thickness: 3,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Stats',
                        style: SafeGoogleFont(
                          'Cabinet Grotesk Variable',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.2575,
                          color: const Color(0xff151515),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  'Answered:',
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2575,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  (rightAnswers + wrongAnswers).toString(),
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2575,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                  flex: 1,
                                  child: Icon(Icons.check,
                                      color: Color(0xff42AE5A))),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Right answers:',
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  rightAnswers.toString(),
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                  flex: 1,
                                  child: Icon(Icons.close,
                                      color: Color(0xffFF4F4F))),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Wrong answers:',
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  wrongAnswers.toString(),
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff151515),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 47, right: 47),
                        child: TextButton(
                          onPressed: () async {
                            await StatsPreferences.setAnswered(
                                (rightAnswers + wrongAnswers),
                                rightAnswers,
                                wrongAnswers);

                            if (appState.soundIsSelected) {
                              AudioPlayer()
                                  .play(AssetSource(AudioPath().clickSound));
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MenuScreen(appState: appState)));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 68,
                            decoration: BoxDecoration(
                              color: Color(0xff571530),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              // buttonfBa (I10:1696;34:24)
                              margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                              width: 311,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff561430)),
                                color: Color(0xfff03985),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Go Back To Menu',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2575,
                                    color: Color(0xfffff9e4),
                                  ),
                                ),
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
      ),
    );
  }
}
