import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/utils.dart';

class StatsOverlay extends StatefulWidget {
  final MyAppState appState;

  StatsOverlay({super.key, required this.appState});

  @override
  State<StatsOverlay> createState() => _StatsOverlayState();
}

class _StatsOverlayState extends State<StatsOverlay> {
  int answered = 0, right = 0, wrong = 0;

  @override
  void initState() {
    super.initState();
    answered = StatsPreferences.getAnswered() ?? 0;
    right = StatsPreferences.getRightAnswers() ?? 0;
    wrong = StatsPreferences.getWrongAnswers() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfffff9e4),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 76,
              color: const Color(0xffffffff),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 17, 0, 17),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      if (widget.appState.soundIsSelected) {
                        AudioPlayer().play(AssetSource(AudioPath().clickSound));
                      }
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/page-1/images/cancel.png',
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
          const SizedBox(
            height: 153,
          ),
          Text(
            // labelSoE (I3:347;19:257)
            'Total Stats',
            style: SafeGoogleFont(
              'Cabinet Grotesk Variable',
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: const Color(0xff151515),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, top: 18, right: 40),
                child: Text(
                  'Answered:',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff151515),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 54, top: 18),
                child: Text(
                  answered.toString(),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 26),
                  child: Icon(Icons.check, color: Color(0xff42AE5A)),
                ),
                Text(
                  'Right answers:',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff151515),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    right.toString(),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 26),
                  child: Icon(Icons.close, color: Color(0xffFF4F4F)),
                ),
                Text(
                  'Wrong answers:',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff151515),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    wrong.toString(),
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
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: TextButton(
                onPressed: () {
                  if (widget.appState.soundIsSelected) {
                    AudioPlayer().play(AssetSource(AudioPath().clickSound));
                  }
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 72,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 4,
                        top: 4,
                        child: Align(
                          child: SizedBox(
                            width: 183,
                            height: 68,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff571530),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 175,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff561430)),
                          color: const Color(0xfff03985),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                color: Color(0xff3D0F22),
                                size: 17,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Leave',
                                  style: SafeGoogleFont(
                                    'Cabinet Grotesk Variable',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2575,
                                    color: const Color(0xff3D0F22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
