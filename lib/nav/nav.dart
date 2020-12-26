import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/budget/payments/payments_page.dart';
import 'package:to_pay_app/calendar/calendar_page.dart';

class NavPage extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<NavPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Page 1: Home',
      style: optionStyle,
    ),
    PaymentsPage(),
    CalendarScreen(),
    Text(
      'Page 4: More',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Finance',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 40, top: 10),
            child: Text(
              "Balance:",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),

          // IconButton(
          //   icon: Icon(
          //     Icons.settings_outlined,
          //     size: 27,
          //     color: Colors.black,

          //   ),
          // onPressed: () {
          // do something
          //  },
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Budget',
                  ),
                  GButton(
                    icon: Icons.calendar_today_outlined,
                    text: 'Calendar',
                  ),
                  GButton(
                    icon: Icons.more_horiz_outlined,
                    text: 'More',
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          AddPaymentsPage();
        },
      ),
      
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'First Activity Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'Second Activity Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'Third Activity Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}

//  floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),

// bottomNavigationBar: CurvedNavigationBar(
//   backgroundColor: Colors.red,
//   buttonBackgroundColor: Colors.white,
//   height: 50,
//   items: <Widget>[
//     Icon(Icons.home_outlined, size: 22, color: Colors.black),
//     Icon(Icons.account_balance_wallet_outlined, size: 22, color: Colors.black),
//     Icon(Icons.calendar_today_outlined, size: 22, color: Colors.black),
//     Icon(Icons.menu, size: 22, color: Colors.black),
//     //Icon(Icons.menu, size: 25, color: Colors.black)
//   ],
//   animationDuration: Duration(milliseconds: 200),
//   onTap: (index) {

//   },
// ),
