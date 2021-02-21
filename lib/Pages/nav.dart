import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_pay_app/Pages/missedPayments.dart';
import 'package:to_pay_app/Pages/paidPayements.dart';
import 'package:to_pay_app/Pages/paymentsTabbedView.dart';
import 'package:to_pay_app/Pages/setThemePage.dart';
import 'package:to_pay_app/Pages/unpaidPayments.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/userPage.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/Pages/allPayments.dart';
import 'package:to_pay_app/Pages/calendar/calendar_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/Pages/home.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:to_pay_app/nav/myhomepage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:to_pay_app/nav/nm_box.dart';
//selectedIndex: _selectedIndex,

class NavPage extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<NavPage> {
  int _selectedIndex = 0;

  void changeTab() {
    if (mounted) setState(() {});
  }
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  SnakeShape snakeShape = SnakeShape.indicator;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  // ShapeBorder bottomBarShape = const RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(25)),
  // );
  EdgeInsets padding = const EdgeInsets.all(12);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PaymentsTabbedPage(),
    CalendarPage(),
    SetThemePage(),
    Text("Temp"),
    //MyHomePage(),
  ];
  // final Shader colorGradient =
  //     LinearGradient(colors: <Color>[Color(0xff1959F0), Color(0xff39D3E0)])
  //         .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
       final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: themeProvider.themeMode().navBarColor,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        //shape: bottomBarShape,
        //  padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: themeProvider.themeMode().navBarForeground,
        selectedItemColor: snakeShape == SnakeShape.indicator ? themeProvider.themeMode().navBarForeground : null,
        unselectedItemColor: themeProvider.themeMode().unselectedItemColor,

        ///configuration for SnakeNavigationBar.gradient
        //snakeViewGradient: selectedGradient,
        //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        //unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.creditcard), label: 'Expenses'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.paintbrush), label: 'Theme'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_pie), label: 'Analytics')
        ],
      ),
    );
  }
}
