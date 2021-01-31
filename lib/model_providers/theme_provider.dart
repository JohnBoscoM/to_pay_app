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
    );

    

  }
  CategoryIcon categoryIcon([String category]) {
    try{
 return CategoryIcon(
    name: category,
    color: getColor(category),
    icon:  getIcon(category)
  );
    }catch(e){
return CategoryIcon(
    name: '',
    color: Colors.black,
    icon:  Icons.hail
  );
    }
 
}
}

Color getColor(String category) {
  if (category == 'Household') {
    return Colors.red[400];
  }
  if (category == 'Food') {
    return Colors.greenAccent;
  }
  if (category == 'Fitness') {
    return Colors.red[400];
  }
  if (category == 'Education') {
    return Colors.brown[400];
  }
  if (category == 'Shopping') {
    return Colors.purple[400];
  }
  if (category == 'Entertainment') {
    return Colors.pink[400];
  }
  if (category == 'Car') {
    return Colors.blue[400];
  }
  if (category == 'Other') {
    return Colors.grey[400];
  }

   if (category == 'Broadband') {
    return Colors.orange[400];
  }
  return Colors.red[400];
}

IconData getIcon(String category) {
  if (category == 'Accomodation') {
    return Icons.home_filled;
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
  if (category == 'Other') {
    return Icons.menu;
  }

    if (category == 'Broadband') {
    return Icons.web;
  }
  return Icons.home_filled;
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
  Color appColor;
  Color blendBackgroundColor;
  List<BoxShadow> itemShadow;
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
      this.itemShadow,
      this.color});
}

class CategoryIcon {
  IconData icon;
  String name;
  Color color;

  CategoryIcon({this.name, this.icon, this.color});
}

// Provider finished
