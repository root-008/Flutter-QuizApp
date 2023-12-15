import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/menu-screen.dart';
import 'package:myapp/utils.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.appState});

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        padding: EdgeInsets.only(top: padding.top),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff151515)),
          color: const Color(0xfffff9e4),
          image: const DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              'assets/page-1/images/image-1-bg.png',
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(top: padding.top),
                child: Text(
                  'QuizQuest',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    height: 1.2575,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
                child: Text(
                  'Embark on a Journey of Knowledge with QuizQuest!',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    height: 1.2575,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  SizedBox(
                    width: 183,
                    height: 68,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff571530),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (appState.soundIsSelected) {
                        AudioPlayer().play(AssetSource(AudioPath().clickSound));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuScreen(
                                    appState: appState,
                                  )));
                    },
                    child: Container(
                      width: 175,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff561430)),
                        color: const Color(0xfff03985),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Start Game',
                          style: SafeGoogleFont(
                            'Cabinet Grotesk Variable',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2575,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
