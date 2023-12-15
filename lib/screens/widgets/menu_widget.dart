import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/categories_ready_screen.dart';
import 'package:myapp/utils.dart';

class MenuAppBarWidget {
  Widget menuAppBar(var padding, var context, Function() openDrawer2,
      Function() openDrawer1, MyAppState appState) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: padding.top),
      child: Container(
        // topbarBwr (3:346)
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
        padding: const EdgeInsets.fromLTRB(0, 17, 0, 17),
        width: width,
        height: 76,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff151515)),
          color: const Color(0xffffffff),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Flexible(
              flex: 2,
              child: InkWell(
                  onTap: () {
                    if (appState.soundIsSelected) {
                      AudioPlayer().play(AssetSource(AudioPath().clickSound));
                    }
                    openDrawer2();
                  },
                  child: Image.asset(
                    'assets/page-1/images/menu_icon.png',
                  )),
            ),
            SizedBox(
              width: width / 1.7,
            ),
            Flexible(
              flex: 5,
              child: InkWell(
                onTap: () {
                  if (appState.soundIsSelected) {
                    AudioPlayer().play(AssetSource(AudioPath().clickSound));
                  }
                  openDrawer1();
                },
                child: Stack(
                  children: [
                    Positioned(
                      // shadowV5N (I3:347;19:248)
                      left: 4,
                      top: 4,
                      child: SizedBox(
                        width: 108,
                        height: 38,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff594a16),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // buttonqoS (I3:347;19:249)
                      left: 4,
                      top: 4,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(23.5, 5, 0, 4),
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff594a16)),
                          color: Color(0xfff2ca3b),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // statsiconLVJ (I3:347;19:250)
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 1),
                              width: 12,
                              height: 10.91,
                              child: Image.asset(
                                'assets/page-1/images/stats-icon.png',
                                width: 12,
                                height: 10.91,
                              ),
                            ),
                            Text(
                              // labelSoE (I3:347;19:257)
                              'Stats',
                              style: SafeGoogleFont(
                                'Cabinet Grotesk Variable',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.2575,
                                color: Color(0xff594a16),
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
          ],
        ),
      ),
    );
  }
}

class MenuHeader {
  Widget menuHeader() {
    return Container(
      // groupheaderZ7A (10:43)
      margin: const EdgeInsets.fromLTRB(44, 0, 44, 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // titlegha (4:29)
            margin: const EdgeInsets.fromLTRB(0, 0, 7, 9),
            child: Text(
              'Choose a Category',
              style: SafeGoogleFont(
                'Cabinet Grotesk Variable',
                fontSize: 32,
                fontWeight: FontWeight.w800,
                height: 1.2575,
                color: const Color(0xff151515),
              ),
            ),
          ),
          Container(
              // separationline1E4 (4:28)
              width: 327,
              height: 2,
              color: const Color(0xff151515)),
        ],
      ),
    );
  }
}

class MenuCards {
  Widget menuCardsRowLeft(String category, String asset, BuildContext context,
      MyAppState appState) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          if (appState.soundIsSelected) {
            AudioPlayer().play(AssetSource(AudioPath().clickSound));
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoriesReadyScreen(
                    category,
                    appState: appState,
                  )));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Container(
                width: 127,
                height: 127,
                decoration: ShapeDecoration(
                  color: const Color(0xFFDA8300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x63DB8300),
                      blurRadius: 5,
                      offset: Offset(5, 5),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Image.asset(
                    asset,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 8),
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Cabinet Grotesk Variable',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuCardsRowRight(String category, String asset, BuildContext context,
      MyAppState appState) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          if (appState.soundIsSelected) {
            AudioPlayer().play(AssetSource(AudioPath().clickSound));
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoriesReadyScreen(
                    category,
                    appState: appState,
                  )));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Container(
                width: 127,
                height: 127,
                decoration: ShapeDecoration(
                  color: const Color(0xFFDA8300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x63DB8300),
                      blurRadius: 5,
                      offset: Offset(5, 5),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Image.asset(
                    asset,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35, top: 8),
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Cabinet Grotesk Variable',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
