import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_pay_app/customs/z_animated_toggle.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SetThemePage extends StatefulWidget {
  @override
  _SetThemePageState createState() => _SetThemePageState();
}

class _SetThemePageState extends State<SetThemePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // PaymentList pl = new PaymentList();
  final Shader colorGradient =
      LinearGradient(colors: <Color>[Colors.grey[900], Colors.grey[400]])
          .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool darkMode = false;
    return CupertinoPageScaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
        child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        CupertinoSliverNavigationBar(
          backgroundColor: themeProvider.themeMode().blendBackgroundColor,
          largeTitle: Text(
            "Settings",
            style: TextStyle(
                color: themeProvider.themeMode().textColor,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w800),
          ),
        ),
      ];
    },
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(3),
            decoration:
            BoxDecoration(
              color: themeProvider.themeMode().blendBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: themeProvider.themeMode().navBarColor
                ),
              ),
            ),
            child: ListTile(
              title: Text('Dark Mode', style: TextStyle(fontFamily:'avenir', fontSize: 20, fontWeight: FontWeight.w700)),
              trailing: CupertinoSwitch(
                value: darkMode,
                onChanged: (bool value) {
                  setState(() {
                    darkMode = value;
                     changeThemeMode(darkMode, themeProvider);
                  }
                  );
                  },
              ),
            ),
          ),

                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );

  }
// function to toggle circle animation
  changeThemeMode(bool theme, ThemeProvider themeProvider) {
    if (!theme) {
      themeProvider.toggleThemeData();
    } else {
      themeProvider.toggleThemeData();
    }
  }
  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}
