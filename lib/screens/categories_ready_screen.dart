import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/menu_overlay.dart';
import 'package:myapp/screens/quiz_question_screen.dart';
import 'package:myapp/utils.dart';

class CategoriesReadyScreen extends StatefulWidget {
  const CategoriesReadyScreen(this.type, {super.key, required this.appState});

  final String type;
  final MyAppState appState;

  @override
  State<CategoriesReadyScreen> createState() => _CategoriesReadyScreenState();
}

class _CategoriesReadyScreenState extends State<CategoriesReadyScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.appState.pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      if (widget.appState.isMusicPlaying) {
        widget.appState.resumeMusic();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuOverlay(appState: widget.appState),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          // categoryofcomputersUKW (10:1498)
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfffff9e4),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                          if (widget.appState.soundIsSelected) {
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
                            'assets/page-1/images/menu_icon.png',
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
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    widget.type,
                    style: SafeGoogleFont(
                      'Cabinet Grotesk Variable',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.2575,
                      color: const Color(0xff151515),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    'Are You Ready!',
                    style: SafeGoogleFont(
                      'Cabinet Grotesk Variable',
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      height: 1.2575,
                      color: const Color(0xff151515),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.25,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextButton(
                      onPressed: () {
                        if (widget.appState.soundIsSelected) {
                          AudioPlayer()
                              .play(AssetSource(AudioPath().clickSound));
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizQuestionScreen(
                                      type: widget.type,
                                      appState: widget.appState,
                                    )));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xff571530),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          // buttonHbi (I10:1559;34:24)
                          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          width: 311,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff561430)),
                            color: const Color(0xfff03985),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Start',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
