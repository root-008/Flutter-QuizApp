import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/utils.dart';

class MenuOverlay extends StatefulWidget {
  @override
  _MenuOverlayState createState() => _MenuOverlayState();

  final MyAppState appState;

  MenuOverlay({required this.appState});
}

class _MenuOverlayState extends State<MenuOverlay> {
  late bool musicIsSelected;
  late bool soundIsSelected;
  String deactiveButton = 'assets/page-1/images/switch-Ldr.png';
  String activeButton = 'assets/page-1/images/switch-Ldr-active.png';
  String selectedMusic = '';
  String selectedSound = '';

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    musicIsSelected = widget.appState.musicIsSelected;
    soundIsSelected = widget.appState.soundIsSelected;
  }

  @override
  Widget build(BuildContext context) {
    selectedMusic =
        widget.appState.musicIsSelected ? activeButton : deactiveButton;
    selectedSound =
        widget.appState.soundIsSelected ? activeButton : deactiveButton;
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
                      if (soundIsSelected) {
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
          Padding(
            padding: const EdgeInsets.only(left: 23, top: 32),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                // labelSoE (I3:347;19:257)
                'Settings',
                style: SafeGoogleFont(
                  'Cabinet Grotesk Variable',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff151515),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 26),
                  child: Icon(Icons.music_note, color: Color(0xff151515)),
                ),
                Text(
                  'Music:',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff151515),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextButton(
                    onPressed: () async {
                      if (musicIsSelected) {
                        widget.appState.stopMusic();
                      } else {
                        widget.appState.playMusic();
                      }
                      if (soundIsSelected) {
                        player.play(AssetSource(AudioPath().clickSound));
                      }
                      setState(() {
                        musicIsSelected = !musicIsSelected;
                        selectedMusic =
                            musicIsSelected ? activeButton : deactiveButton;
                        widget.appState.musicIsSelected = musicIsSelected;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 76,
                      height: 44,
                      child: Image.asset(
                        selectedMusic,
                        width: 76,
                        height: 44,
                      ),
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
                  padding: EdgeInsets.only(left: 26, right: 5),
                  child: ImageIcon(
                    AssetImage('assets/page-1/images/speaker-icon.png'),
                    size: 17,
                  ),
                ),
                Text(
                  'Sound:',
                  style: SafeGoogleFont(
                    'Cabinet Grotesk Variable',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff151515),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: TextButton(
                    // switchmCx (10:1186)
                    onPressed: () {
                      if (!soundIsSelected) {
                        player.play(AssetSource(AudioPath().clickSound));
                      }
                      setState(() {
                        soundIsSelected = !soundIsSelected;
                        selectedSound =
                            soundIsSelected ? activeButton : deactiveButton;
                        widget.appState.soundIsSelected = soundIsSelected;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 76,
                      height: 44,
                      child: Image.asset(
                        selectedSound,
                        width: 76,
                        height: 44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 60),
                child: TextButton(
                  onPressed: () {
                    if (soundIsSelected) {
                      player.play(AssetSource(AudioPath().clickSound));
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
                        Positioned(
                          left: 4,
                          top: 4,
                          child: Container(
                            width: 175,
                            height: 60,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff561430)),
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
                        ),
                      ],
                    ),
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
