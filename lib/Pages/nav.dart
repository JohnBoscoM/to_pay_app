import 'package:flutter/material.dart';
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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    
    PaymentsTabbedPage(),
    CalendarScreen(),  
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
      backgroundColor: themeProvider.themeMode().color,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
      
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: themeProvider.themeMode().color,
                gap: 8,
                activeColor: themeProvider.themeMode().textColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: themeProvider.themeMode().blendBackgroundColor,
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.account_balance_wallet_rounded,
                    text: 'Bills',
                  ),
                  GButton(
                    icon: Icons.calendar_today_rounded,
                    text: 'Calendar',
                  ),
                  //  GButton(
                  //   icon: Icons.analytics_outlined,
                  //   text: 'Analytics',
                  // ),
                  GButton(
                    icon: Icons.brightness_medium_rounded,
                    text: 'Theme',
                  ),
                   GButton(
                    icon: Icons.analytics_rounded,
                    text: 'Analytics',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
