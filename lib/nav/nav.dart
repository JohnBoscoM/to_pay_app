import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/budget/payments/payments_page.dart';
import 'package:to_pay_app/calendar/calendar_page.dart';
import 'package:to_pay_app/home/home.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:to_pay_app/nav/sidebar.dart';


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
    PaymentsPage(),
    CalendarScreen(),
    SideBar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.black,
      
      appBar: AppBar(
        title: const Text(
          'My Wallet',
          style: TextStyle(fontFamily: "avenir", color: Colors.white),
        ),
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 40, top: 10),
            child: Text(
              "Balance:" +"\n" +"24240kr",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: "ubuntu",
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
       bottomNavigationBar: NavigationBar(
         backgroundColor: Colors.grey[800],
          selectedIndex: _selectedIndex,
          showActiveButtonText: false,
          onTabChange: (int index) {
            _selectedIndex = index;
            changeTab();
          },
          // showActiveButtonText: false,
          textStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "ubuntu"),
          navigationBarButtons: <NavigationBarButton>[
            NavigationBarButton(
              
              text: "Home",
              icon: Icons.home,
             backgroundColor: Colors.deepOrange[400],
             
            ),
            NavigationBarButton(
              text: '',
              icon: Icons.account_balance_wallet,
              backgroundColor: Colors.deepOrange[400]
            ),
              NavigationBarButton(
              text: '',
              icon: Icons.calendar_today,
              backgroundColor: Colors.deepOrange[400]
              ,
            ),
            NavigationBarButton(
              text: 'Tab 3',
              icon: Icons.more_horiz,
              backgroundColor: Colors.deepOrange[400],
            )
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange[400],
        //Color(0xffffac30),
        child: Icon(
          Icons.add,
          color: Colors.black,
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
