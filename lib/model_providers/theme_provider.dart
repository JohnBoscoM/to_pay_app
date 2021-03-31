import 'package:flutter/cupertino.dart';
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
        if (isLightTheme) ...[Colors.blueGrey[900], Colors.blueGrey[600]],
        if (!isLightTheme) ...[Colors.blueGrey[900], Colors.blueGrey[600]]
      ],
      backgroundGradient: [
        if (isLightTheme) ...[Color(0xff000000), Color(0xff383838)],
        if (!isLightTheme) ...[Color(0xff000000), Color(0xff383838)]
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
      textColor: isLightTheme ? Color(0xff494949) : Color(0xFFFFFFFF),
      appBarColor: isLightTheme ? Colors.white54: Colors.transparent,
      chipColor: isLightTheme ? Colors.blueAccent[700] : Colors.blueAccent[700],
      borderColor: isLightTheme ? Colors.grey[300] : Color(0xFF383838),
      statusCardColor:  isLightTheme ? Colors.deepPurple[300]: Color(0xff4c2eac),
      statusTextCardColor:isLightTheme ? Colors.deepPurple[800] : Color(0xff8167e0),
      secondaryTextColor: isLightTheme ? Colors.blueGrey : Color(0xFFFFFFFF),
      selectedColor: isLightTheme ? Colors.deepPurple : Colors.deepPurple[800],
      navBarForeground: isLightTheme ?  Colors.blueGrey[700] : Colors.blueGrey,
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      searchBarColor: isLightTheme ? Color.fromARGB(125, 206, 206, 206) : Color.fromARGB(15, 255, 250, 255),
      formColor: isLightTheme ? Color.fromARGB(15, 60, 0, 255) : Color.fromARGB(50, 255, 250, 255),
      unselectedItemColor: isLightTheme ? Colors.blueGrey[600] : Colors.blueGrey,
      tileColor: isLightTheme ? Colors.grey[100] : Color(0xff1c1c1c),
      nightOrDayImage: isLightTheme
          ? "assets/images/hugo-dogw.png"
          : 'assets/images/hugo-cat-sleep.png',
        //FFA081  FFED5221
      toggleBackgroundColor:
          isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
      color: isLightTheme ? Colors.white : Color(0xff1c1c1c),
      appColor: isLightTheme ? Color(0xFF262626) : Color(0xffaf5b41),
      mainCardSecondaryColor:  isLightTheme ? Color(0xffeaeaea) : Color(0xffeaeaea),
      blendBackgroundColor: isLightTheme ? Color(0xffffffff) : Color(0xff111111),
      navBarColor: isLightTheme ? Color(0xffeae9ec) : Color(0xff1a1a21),
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
      itemShadow: [
        if (isLightTheme)
          BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(-10, 10)),
        if (!isLightTheme)
          BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(-10, 10)),
      ],
      mainItemShadow: [
        if (isLightTheme)
          BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(-10, 10)),
        if (!isLightTheme)
          BoxShadow(
              color: Color(0xce211e26),
              blurRadius: 0,
              spreadRadius: 0,
              offset: Offset(0, 0)),
      ],
    );
  }

  CategoryIcon categoryIcon(String category) {
    try {
      return CategoryIcon(
          name: category, color: getColor(category), icon: getIcon(category));
    } catch (e) {
      return CategoryIcon(name: '', color: Colors.black, icon: Icons.hail);
    }
  }
}

Color getColor(String category) {
  if (category == 'Household') {
    return Colors.blueGrey[300];
  }
  if (category == 'Food') {
    return Colors.blueGrey[300];
  }
  if (category == 'Fitness') {
    return Colors.blueGrey[400];
  }
  if (category == 'Education') {
    return Colors.blueGrey[400];
  }
  if (category == 'Shopping') {
    return Colors.blueGrey[400];
  }
  if (category == 'Entertainment') {
    return Colors.blueGrey[400];
  }
  if (category == 'Car') {
    return Colors.blueGrey[400];
  }
  if (category == 'Other') {
    return Colors.blueGrey[400];
  }

  if (category == 'Electricty') {
    return Colors.blueGrey[400];
  }
  return Colors.blueGrey[300];
}

IconData getIcon(String category) {
  if (category == 'Household') {
    return Icons.home_rounded;
  }
  if (category == 'Food') {
    return Icons.restaurant_menu_rounded;
  }
  if (category == 'Fitness') {
    return Icons.fitness_center_rounded;
  }
  if (category == 'Education') {
    return Icons.menu_book_rounded;
  }
  if (category == 'Shopping') {
    return Icons.shopping_bag_rounded;
  }
  if (category == 'Entertainment') {
    return Icons.computer_rounded;
  }
  if (category == 'Car') {
    return Icons.directions_car_rounded;
  }
  if (category == 'Electricty') {
    return Icons.bolt;
  }
  if (category == 'Other') {
    return CupertinoIcons.cube;
  }

  if (category == 'Broadband') {
    return Icons.web;
  }
  return CupertinoIcons.cube;
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color> gradient;
  List<Color> backgroundGradient;
  List<Color> unpaidGradient;
  List<Color> paidGradient;
  List<Color> missedGradient;
  String nightOrDayImage;
  Color backgroundColor;
  Color navBarColor;
  Color searchBarColor;
  Color formColor;
  Color unselectedItemColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color chipColor;
  Color textColor;
  Color borderColor;
  Color statusCardColor;
  Color statusTextCardColor;
  Color secondaryTextColor;
  Color color;
  Color mainCardSecondaryColor;
  Color navBarForeground;
  Color selectedColor;
  Color appColor;
  Color appBarColor;
  Color tileColor;
  Color blendBackgroundColor;
  List<BoxShadow> itemShadow;
  List<BoxShadow> mainItemShadow;
  List<BoxShadow> shadow;

  ThemeColor(
      {this.gradient,
      this.backgroundColor,
        this.appBarColor,
        this.tileColor,
        this.mainItemShadow,
      this.toggleBackgroundColor,
      this.toggleButtonColor,
        this.chipColor,
        this.statusTextCardColor,
        this.statusCardColor,
      this.textColor,
        this.borderColor,
        this.secondaryTextColor,
        this.unselectedItemColor,
      this.shadow,
        this.navBarColor,
      this.appColor,
      this.searchBarColor,
        this.formColor,
      this.blendBackgroundColor,
        this.navBarForeground,
      this.backgroundGradient,
      this.paidGradient,
      this.missedGradient,
      this.unpaidGradient,
        this.mainCardSecondaryColor,
      this.itemShadow,
      this.selectedColor,
      this.color,
      this.nightOrDayImage});
}

class CategoryIcon {
  IconData icon;
  String name;
  Color color;

  CategoryIcon({this.name, this.icon, this.color});
}

// Provider finished
