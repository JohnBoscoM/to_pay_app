import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
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
                duration: Duration(milliseconds: 200),
                tabBackgroundColor: Colors.grey[800],
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