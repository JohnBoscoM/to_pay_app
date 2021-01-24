import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_pay_app/Pages/missedPayments.dart';
import 'package:to_pay_app/Pages/payedPayements.dart';
import 'package:to_pay_app/Pages/paymentsTabbedView.dart';
import 'package:to_pay_app/Pages/setThemePage.dart';
import 'package:to_pay_app/Pages/upcomingPayments.dart';
import 'package:to_pay_app/Pages/userPage.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/Pages/allPayments.dart';
import 'package:to_pay_app/calendar/calendar_page.dart';
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
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
      
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Bills',
                  ),
                  GButton(
                    icon: Icons.calendar_today_outlined,
                    text: 'Calendar',
                  ),
                  //  GButton(
                  //   icon: Icons.analytics_outlined,
                  //   text: 'Analytics',
                  // ),
                  GButton(
                    icon: Icons.brightness_medium_outlined,
                    text: 'Theme',
                  ),
                   GButton(
                    icon: Icons.person_outline,
                    text: 'My Profile',
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