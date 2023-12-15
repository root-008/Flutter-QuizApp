import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

class FilePaths {
  String computersPath = 'assets/questions/computers.json';
  String animalsPath = 'assets/questions/animals.json';
  String historyPath = 'assets/questions/history.json';
  String mathematicsPath = 'assets/questions/mathematics.json';
  String musicPath = 'assets/questions/music.json';
  String vehiclesPath = 'assets/questions/vehicles.json';
  String televisionPath = 'assets/questions/television.json';
  String filmPath = 'assets/questions/film.json';
}

class AudioPath {
  String clickSound = 'sounds/click.mp3';
  String successSound = 'sounds/success.mp3';
  String wrongSound = 'sounds/wrong.mp3';
  String endSound = 'sounds/endSound.mp3';
}

class StatsPreferences {
  static SharedPreferences? _preferences;

  static const _keyAnswered = 'answered';
  static const _keyRight = 'rightAnswers';
  static const _keyWrong = 'wrongAnswers';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAnswered(int answered, int right, int wrong) async {
    int a = getAnswered() ?? 0;
    int r = getRightAnswers() ?? 0;
    int w = getWrongAnswers() ?? 0;

    _preferences!.setInt(_keyAnswered, (answered + a));
    _preferences!.setInt(_keyRight, (right + r));
    _preferences!.setInt(_keyWrong, (wrong + w));
  }

  static int? getAnswered() => _preferences!.getInt(_keyAnswered);
  static int? getRightAnswers() => _preferences!.getInt(_keyRight);
  static int? getWrongAnswers() => _preferences!.getInt(_keyWrong);
}
