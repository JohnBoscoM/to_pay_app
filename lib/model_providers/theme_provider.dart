import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeData _themeData;

  ThemeProvider({this.isLightTheme});

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }

  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF26242e),
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  // use to toggle the theme
  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : Color(0xFF1E1F28),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
      scaffoldBackgroundColor:
          isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      gradient: [
        if (isLightTheme) ...[Colors.orange[900], Colors.yellow[400]],
        if (!isLightTheme) ...[Color(0xffDABB5F), Color(0xffF2EDD2)]
      ],
      backgroundGradient: [
        if (isLightTheme) ...[Color(0xff5F3193), Color(0xff372571)],
        if (!isLightTheme) ...[Color(0xff5F3193), Color(0xff372571)]
      ],
         unpaidGradient: [
        if (isLightTheme) ...[Colors.blue, Colors.blue],
        if (!isLightTheme) ...[Color(0xffDABB5F), Color(0xffF2EDD2)]
      ],
         paidGradient: [
        if (isLightTheme) ...[Colors.greenAccent[400], Colors.greenAccent[400]],
        if (!isLightTheme) ...[Color(0xffDABB5F), Color(0xffF2EDD2)]
      ],
         missedGradient: [
        if (isLightTheme) ...[Colors.red, Colors.red],
        if (!isLightTheme) ...[Color(0xffDABB5F), Color(0xffF2EDD2)]
      ],
      textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
      selectedColor: isLightTheme ? Colors.deepPurple: Colors.deepPurple[800],
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      toggleBackgroundColor:
          isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
      color: isLightTheme ? Colors.white : Color(0xff1C1B28),
      appColor: isLightTheme ? Color(0xFF6C60E0) : Colors.deepPurple,
      blendBackgroundColor:
          isLightTheme ? Color(0xffEEEDF7) : Color(0xff28273A),
      shadow: [
        if (isLightTheme)
          BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5)),
        if (!isLightTheme)
          BoxShadow(
              color: Color(0x66000000),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5))
      ],
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color> gradient;
  List<Color> backgroundGradient;
   List<Color> unpaidGradient;
    List<Color> paidGradient;
     List<Color> missedGradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  Color color;
  Color selectedColor;
  Color appColor;
  Color blendBackgroundColor;
  List<BoxShadow> shadow;

  ThemeColor(
      {this.gradient,
      this.backgroundColor,
      this.toggleBackgroundColor,
      this.toggleButtonColor,
      this.textColor,
      this.shadow,
      this.appColor,
      this.blendBackgroundColor,
      this.backgroundGradient,
      this.paidGradient,
      this.missedGradient,
      this.unpaidGradient,
      this.color,
      this.selectedColor,});
}

// Provider finished
