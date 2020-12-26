import 'package:flutter/material.dart';
import 'nav/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Pay',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.black
        ),  
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavPage(),  
    );
  }
}

