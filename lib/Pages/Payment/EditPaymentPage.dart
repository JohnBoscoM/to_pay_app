import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/Payment/Forms/CustomForms.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';


class EditPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.themeMode().blendBackgroundColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Edit Payment',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 30,
                          color: themeProvider.themeMode().textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ), //
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'Edit Payment Details',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 15,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(left: 38, right: 68),
                    child: Column(

                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: scrWidth,
                          child: Text(
                            'Recurrence: ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Chip(
                              backgroundColor: Colors.deepPurple,
                              label: Text("Quaterly"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Chip(
                              backgroundColor: Colors.deepPurple,
                              label: Text("Monthly"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Chip(
                              backgroundColor: Colors.deepPurple,
                              label: Text("Weekly"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  //

                  SizedBox(
                    height: 30,
                  ),
                  //
                  CustomForms(
                    label: 'Title',
                    inputHint: 'Rent',
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  CustomForms(
                    label: 'Cost',
                    inputHint: '4500',
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  CustomForms(
                    label: 'Due Date',
                    inputHint: new DateTime.now().toString().substring(0,10),
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    "Payment will be registered as a one time payment if\nno recurrence option is chosen",
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8f9db5).withOpacity(0.45),
                    ),
                    //
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: scrWidth * 0.85,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Payment',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Already have an account? ',
                  //         style: TextStyle(
                  //           fontFamily: 'Product Sans',
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xff8f9db5).withOpacity(0.45),
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: 'Sign In',
                  //         style: TextStyle(
                  //           fontFamily: 'Product Sans',
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xff90b7ff),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.deepPurple,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Colors.deepPurple[800],
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Neu_button extends StatelessWidget {
  Neu_button({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xff0962FF),
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
