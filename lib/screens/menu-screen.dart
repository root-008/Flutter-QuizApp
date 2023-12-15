import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/menu_overlay.dart';
import 'package:myapp/screens/stats_overlay.dart';
import 'package:myapp/screens/widgets/menu_widget.dart';

class MenuScreen extends StatefulWidget {
  final MyAppState appState;
  MenuScreen({super.key, required this.appState});

  @override
  State<StatefulWidget> createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawer1Open = false;
  bool isDrawer2Open = false;

  void openDrawer1() {
    setState(() {
      isDrawer1Open = true;
      isDrawer2Open = false; // Diğer çekmecenin kapalı olduğundan emin olun
    });
    _scaffoldKey.currentState
        ?.openDrawer(); // Drawer'ı açmak için ScaffoldState'e erişim
  }

  void openDrawer2() {
    setState(() {
      isDrawer1Open = false; // Diğer çekmecenin kapalı olduğundan emin olun
      isDrawer2Open = true;
    });
    _scaffoldKey.currentState
        ?.openEndDrawer(); // Drawer'ı açmak için ScaffoldState'e erişim
  }

  void closeDrawer1() {
    setState(() {
      isDrawer1Open = false;
    });
    Navigator.of(context).pop(); // Drawer'ı kapatmak için Navigator kullanımı
  }

  void closeDrawer2() {
    setState(() {
      isDrawer2Open = false;
    });
    Navigator.of(context).pop(); // Drawer'ı kapatmak için Navigator kullanımı
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
    //var width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: isDrawer1Open
          ? StatsOverlay(
              appState: widget.appState,
            )
          : MenuOverlay(
              appState: widget.appState,
            ),
      drawer: isDrawer2Open
          ? MenuOverlay(
              appState: widget.appState,
            )
          : StatsOverlay(
              appState: widget.appState,
            ),
      body: SingleChildScrollView(
        child: Container(
          // menuscreengEQ (3:326)
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfffff9e4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuAppBarWidget().menuAppBar(
                  padding, context, openDrawer2, openDrawer1, widget.appState),
              MenuHeader().menuHeader(),
              Row(
                children: <Widget>[
                  MenuCards().menuCardsRowLeft(
                      "Computers",
                      "assets/page-1/images/cpu-EVz.png",
                      context,
                      widget.appState),
                  const SizedBox(
                    width: 90,
                  ),
                  MenuCards().menuCardsRowRight("Mathematics",
                      "assets/page-1/images/base.png", context, widget.appState)
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Row(
                children: <Widget>[
                  MenuCards().menuCardsRowLeft("History",
                      "assets/page-1/images/h.png", context, widget.appState),
                  const SizedBox(
                    width: 90,
                  ),
                  MenuCards().menuCardsRowRight(
                      "Music",
                      "assets/page-1/images/musicfill.png",
                      context,
                      widget.appState),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Row(
                children: <Widget>[
                  MenuCards().menuCardsRowLeft("Animals",
                      "assets/page-1/images/a.png", context, widget.appState),
                  const SizedBox(
                    width: 90,
                  ),
                  MenuCards().menuCardsRowRight(
                      "Vehicles",
                      "assets/page-1/images/car-logo.png",
                      context,
                      widget.appState),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Row(
                children: <Widget>[
                  MenuCards().menuCardsRowLeft(
                      "Film",
                      "assets/page-1/images/cameraduotone.png",
                      context,
                      widget.appState),
                  const SizedBox(
                    width: 90,
                  ),
                  MenuCards().menuCardsRowRight(
                      "Television",
                      "assets/page-1/images/music-and-sound-player-airplay.png",
                      context,
                      widget.appState),
                ],
              ),
              const SizedBox(
                height: 46,
              )
            ],
          ),
        ),
      ),
    );
  }
}
