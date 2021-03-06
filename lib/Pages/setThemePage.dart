import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: themeProvider.themeMode().color,
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: width * 0.35,
                    height: width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: themeProvider.themeMode().gradient,
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft),
                    ),
                  ),
                  // Transform.translate(
                  //   offset: Offset(40, 0),
                  //   child: ScaleTransition(
                  //     scale: _animationController.drive(
                  //       Tween<double>(begin: 0.0, end: 1.0).chain(
                  //         CurveTween(curve: Curves.decelerate),
                  //       ),
                  //     ),
                  //     alignment: Alignment.topRight,
                  //     child: Container(
                  //       width: width * .26,
                  //       height: width * .26,
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: themeProvider.isLightTheme
                  //               ? Colors.white
                  //               : Color(0xFF26242e)),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: height * 0.1),
              Text(
                'Choose a style',
                style: TextStyle(
                    fontSize: width * .06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.03),
              Container(
                width: width * .6,
                child: Text(
                  'Day or night. Customize your interface',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.1),
              ZAnimatedToggle(
                values: ['Light', 'Dark'],
                onToggleCallback: (v) async {
                  await themeProvider.toggleThemeData();
                  setState(() {});
                  changeThemeMode(themeProvider.isLightTheme);
                },
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                  buildDot(
                    width: width * 0.055,
                    height: width * 0.022,
                    color: themeProvider.isLightTheme
                        ? Color(0xFF26242e)
                        : Colors.white,
                  ),
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                ],
              ),
              // skip & next
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // children: <Widget>[
                    //   Padding(
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: width * 0.025),
                    //     child: Text(
                    //       'Skip',
                    //       style: TextStyle(
                    //         fontSize: width * 0.045,
                    //         color: const Color(0xFF7c7b7e),
                    //         fontFamily: 'Rubik',
                    //       ),
                    //     ),
                    //   ),
                    //   RaisedButton(
                    //     onPressed: () {
                    //       _scaffoldKey.currentState.showSnackBar(
                    //         SnackBar(
                    //           content: Text(
                    //             'Loved it? Give a star on Github',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               fontFamily: 'Rubik',
                    //               fontSize: width * 0.045,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     shape: CircleBorder(),
                    //     color: themeProvider.isLightTheme
                    //         ? const Color(0xFFFFFFFF)
                    //         : const Color(0xFF35303f),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(width * 0.05),
                    //       child: Icon(
                    //         Icons.arrow_forward,
                    //         color: themeProvider.isLightTheme
                    //             ? const Color(0xFF000000)
                    //             : const Color(0xFFFFFFFF),
                    //       ),
                    //     ),
                    //   )
                    // ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
// function to toggle circle animation
  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
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
