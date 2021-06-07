import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/search/searchPage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:to_pay_app/controller/paymentController.dart';
import 'package:to_pay_app/domain/Payment/Payments.dart';
import 'package:to_pay_app/helpers/calendar.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/View/Clippers/Clippers.dart';

import 'CustomWidgets/CustomCheckbox.dart';
import 'Payment/AddPaymentPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PaymentController paymentController = new PaymentController();
  List<dynamic> paymentList;
  final paymentBox = Hive.box('paymentBox');
  final month = DateTime.now().month;
  //User user;
  final usernameController = TextEditingController();
  final incomeController = TextEditingController();

  // @override
  // Future<void> initState() {
  //   super.initState();
  //   Hive.registerAdapter(UserAdapter());
  //   _openBox();
  // }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    incomeController.dispose();
    super.dispose();
  }

  int totalAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      amount += value.cost;
    });
    return amount.truncate();
  }

  int totalUnPaidAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == false) {
        amount += value.cost;
      }
    });
    return amount.truncate();
  }

  int totalPaidAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == true) {
        amount += value.cost;
      }
    });
    return amount.truncate();
  }

  int totalMissedAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.deadline.isBefore(new DateTime.now()) &&
          value.isChecked == false) {
        amount = value.cost;
      }
    });
    return amount.truncate();
  }

  int unpaidBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == false) {
        count++;
      }
    });
    return count;
  }

  int paidBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == true) {
        count++;
      }
    });
    return count;
  }

  int missedBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.deadline.isBefore(new DateTime.now()) &&
          value.isChecked == false) {
        count++;
      }
    });
    return count;
  }

  int totalBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      count++;
    });
    return count;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentList = paymentController.getAllPaymentItems();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    Text status(String name) {
      if (name == "Paid") {
        return Text(
          'Total ' + name + " " + paidBillsCount().toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w800),
        );
      }
      if (name == "UnPaid") {
        return Text(
          'Total ' + name + " " + unpaidBillsCount().toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w800),
        );
      }
      if (name == "Missed") {
        return Text(
          'Total ' + name + " " + missedBillsCount().toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w800),
        );
      }
      return Text("Status");
    }

    return SafeArea(
      child: CupertinoPageScaffold(
        backgroundColor: themeProvider.themeMode().blendBackgroundColor,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: themeProvider.themeMode().appBarColor,
                largeTitle: Text(
                  "Home",
                  style: TextStyle(
                      color: themeProvider.themeMode().textColor,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                //padding: EdgeInsets.only(bottom: 10),
                // child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()),
                          );
                        },
                        child: Container()
                        //buildSearchBar(themeProvider),
                        ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    AnimatedContainer(
                      width: _width * 0.95,
                      duration: Duration(milliseconds: 400),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 0, left: 0, right: 0),
                      margin: EdgeInsets.only(
                          top: 25, bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        boxShadow: themeProvider.themeMode().mainItemShadow,
                        // color: themeProvider.themeMode().appColor,
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: LinearGradient(
                            colors: themeProvider.themeMode().gradient,
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                        // gradient: LinearGradient(
                        //     colors: themeProvider.themeMode().backgroundGradient,
                        //     begin: Alignment.bottomRight,
                        //     end: Alignment.topLeft),
                        //Color(0xfff1f3f6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(top: 30, bottom: 0),
                              padding: EdgeInsets.only(
                                  top: 8, bottom: 8, right: 25, left: 45),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(0),
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(0)),
                              ),
                              child: Text(
                                "Overview",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'avenir'),
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icon(
                                  //   CupertinoIcons.bell_fill,
                                  //   size: 40,
                                  //   color: Colors.white,
                                  // ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 0,
                                              right: 15,
                                              left: 15),
                                          // decoration: BoxDecoration(
                                          //   color: themeProvider
                                          //       .themeMode()
                                          //       .mainCardSecondaryColor,
                                          //   borderRadius: BorderRadius.only(
                                          //       bottomRight: Radius.circular(30),
                                          //       bottomLeft: Radius.circular(30),
                                          //       topRight: Radius.circular(30),
                                          //       topLeft: Radius.circular(30)),
                                          // ),
                                          child: Text(
                                            "Total Payments",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'avenir'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              right: 15,
                                              left: 30),
                                          child: Text(
                                            totalBillsCount().toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'avenir'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 0,
                                              right: 15,
                                              left: 15),
                                          // decoration: BoxDecoration(
                                          //   color: themeProvider
                                          //       .themeMode()
                                          //       .mainCardSecondaryColor,
                                          //   borderRadius: BorderRadius.only(
                                          //       bottomRight: Radius.circular(30),
                                          //       bottomLeft: Radius.circular(30),
                                          //       topRight: Radius.circular(30),
                                          //       topLeft: Radius.circular(30)),
                                          // ),
                                          child: Text(
                                            "Total Depth",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'avenir'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              right: 15,
                                              left: 30),
                                          child: Text(
                                            totalUnPaidAmount().toString() +
                                                ' SEK',
                                            // paymentController
                                            //     .getCurrencySymbol(context),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'avenir'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Container(
                                      //  padding: EdgeInsets.only(right: 40),
                                      height: _height * 0.3,

                                      // width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/overview-clip-2.png"),
                                            alignment: Alignment.bottomRight,
                                            fit: BoxFit.scaleDown),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),

                          SizedBox(
                            width: 90,
                          ),

                          // Expanded(
                          //   flex: 0,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 20),
                          //     child: Text(
                          //       "Total Amount: " +
                          //           totalAmount().toString() +
                          //           " SEK",
                          //       style: GoogleFonts.ubuntu(
                          //         color: themeProvider
                          //             .themeMode()
                          //             .mainCardSecondaryColor,
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "avenir"
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 20),
                          //   child: Text(
                          //     "Paid: " +
                          //         totalPaidAmount().toString() +
                          //         " SEK",
                          //     style: GoogleFonts.ubuntu(
                          //       color: themeProvider
                          //           .themeMode()
                          //           .mainCardSecondaryColor,
                          //       fontSize: 22,
                          //       fontWeight: FontWeight.w600,
                          //       fontFamily: "avenir"
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 20),
                          //   child: Text(
                          //     "Total: " + totalBillsCount().toString(),
                          //     style: GoogleFonts.ubuntu(
                          //       color: themeProvider
                          //           .themeMode()
                          //           .mainCardSecondaryColor,
                          //       fontSize: 22,
                          //       fontWeight: FontWeight.w600,
                          //       fontFamily: "avenir"
                          //     ),
                          //   ),
                          // ),
                          //
                          //
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'avenir'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.brown[50],
                        // border:
                        //     Border.all(color: Colors.brown[400], width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: themeProvider.themeMode().mainItemShadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: _width * 0.01),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  "State",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: _width * 0.01),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  'Quantity',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: _width * 0.01),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                child: Text(
                                  'SEK',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  "Paid",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  paidBillsCount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  totalPaidAmount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  "Unpaid",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  unpaidBillsCount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  totalUnPaidAmount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 0),
                                padding: EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: _width * 0.01,
                                    left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  "Missed",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  missedBillsCount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 15, left: 15),
                                // decoration: BoxDecoration(
                                //   color: Colors.white30,
                                //   borderRadius: BorderRadius.only(
                                //       bottomRight: Radius.circular(30),
                                //       bottomLeft: Radius.circular(30),
                                //       topRight: Radius.circular(30),
                                //       topLeft: Radius.circular(30)),
                                // ),
                                child: Text(
                                  totalMissedAmount().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'avenir'),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),

                    // Container(
                    //   margin: EdgeInsets.all(10),
                    //   padding: EdgeInsets.all(10),
                    //   decoration:
                    //   BoxDecoration(
                    //     color: themeProvider.themeMode().color,
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     border: Border.all(color: Colors.grey[300]),
                    //     // boxShadow: themeProvider.themeMode().itemShadow
                    //   ),
                    //   child: ListTile(
                    //     leading: Container(
                    //       height: 70,
                    //       width: 60,
                    //       margin: EdgeInsets.only(right: 0),
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.all(Radius.circular(20)),
                    //           color: Colors.deepPurple[300]
                    //       ),
                    //       child: Icon(
                    //         CupertinoIcons.creditcard_fill,
                    //         color: Colors.deepPurple[900],
                    //         size: 32,
                    //       ),
                    //     ),
                    //     title: Text('Nuvarande Saldo', style: TextStyle(fontFamily:'avenir', fontSize: 17, fontWeight: FontWeight.w700)),
                    //     subtitle: Text("Länsförsäkringar", style: TextStyle(fontFamily:'avenir', fontSize: 13, fontWeight: FontWeight.w700)),
                    //     trailing: Text( '26743' + ' SEK', style: TextStyle(fontFamily:'avenir', fontSize: 20, fontWeight: FontWeight.w700),),
                    //   ),
                    // ),
                    // Container(
                    //   height: _height * 0.45,
                    //   padding: EdgeInsets.only(
                    //       top: 10, bottom: 0, left: 0, right: 0),
                    //   margin: EdgeInsets.only(
                    //       top: 25, bottom: 10, left: 10, right: 10),
                    //   decoration: BoxDecoration(
                    //     boxShadow: themeProvider.themeMode().mainItemShadow,
                    //     //color: themeProvider.themeMode().statusCardColor,
                    //     borderRadius: BorderRadius.all(Radius.circular(35)),

                    //     gradient: LinearGradient(
                    //         colors: themeProvider.themeMode().gradient,
                    //         begin: Alignment.bottomRight,
                    //         end: Alignment.topLeft),
                    //     //Color(0xfff1f3f6),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.only(left: 25),
                    //             padding: EdgeInsets.only(
                    //                 top: 8, bottom: 8, right: 20, left: 20),
                    //             decoration: BoxDecoration(
                    //               color: themeProvider
                    //                   .themeMode()
                    //                   .mainCardSecondaryColor,
                    //               borderRadius: BorderRadius.only(
                    //                   bottomLeft: Radius.circular(30),
                    //                   bottomRight: Radius.circular(30),
                    //                   topRight: Radius.circular(30),
                    //                   topLeft: Radius.circular(30)),
                    //             ),
                    //             child: Text(
                    //               "Status",
                    //               style: GoogleFonts.ubuntu(
                    //                 color: Colors.black,
                    //                 fontSize: 22,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //             ),
                    //           ),

                    //           SizedBox(
                    //             height: 35,
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Text(
                    //               "Unpaid Amount: " +
                    //                   totalUnPaidAmount().toString() +
                    //                   " SEK",
                    //               style: GoogleFonts.ubuntu(
                    //                 color: themeProvider
                    //                     .themeMode()
                    //                     .mainCardSecondaryColor,
                    //                 fontSize: 19,
                    //                 fontWeight: FontWeight.w600,
                    //                 //fontFamily: "avenir"
                    //               ),
                    //             ),
                    //           ),

                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Text(
                    //               "Missed: " + missedBillsCount().toString(),
                    //               style: GoogleFonts.ubuntu(
                    //                 color: themeProvider
                    //                     .themeMode()
                    //                     .mainCardSecondaryColor,
                    //                 fontSize: 19,
                    //                 fontWeight: FontWeight.w700,
                    //                 //fontFamily: "avenir"
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Text(
                    //               "Unpaid: " + unpaidBillsCount().toString(),
                    //               style: GoogleFonts.ubuntu(
                    //                 color: themeProvider
                    //                     .themeMode()
                    //                     .mainCardSecondaryColor,
                    //                 fontSize: 19,
                    //                 fontWeight: FontWeight.w600,
                    //                 //fontFamily: "avenir"
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 10,
                    //           ),

                    //           //
                    //           SizedBox(
                    //             height: 0,
                    //           ),
                    //         ],
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           height: 450,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //             image: DecorationImage(
                    //                 image:
                    //                     AssetImage("assets/images/status2.png"),
                    //                 alignment: Alignment.centerRight,
                    //                 fit: BoxFit.scaleDown),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    // Container(

                    //
                    // SingleChildScrollView(
                    //   padding: EdgeInsets.all(15),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       // Container(
                    //       //   height: 70,
                    //       //   width: 70,
                    //       //   margin: EdgeInsets.only(right: 20),
                    //       //   decoration: BoxDecoration(
                    //       //     shape: BoxShape.circle,
                    //       //     color: Color(0xffffac30),
                    //       //   ),
                    //       //   child: Icon(
                    //       //     Icons.add,
                    //       //     size: 40,
                    //       //   ),
                    //       // ),
                    //       avatarWidget("missed", status("Missed"), themeProvider,
                    //           themeProvider.themeMode().missedGradient),
                    //       avatarWidget("unpaid", status("UnPaid"), themeProvider,
                    //           themeProvider.themeMode().unpaidGradient),
                    //       avatarWidget("paid", status("Paid"), themeProvider,
                    //           themeProvider.themeMode().paidGradient),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            'Payments for ' + monthName(DateTime.now().month),
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'avenir'),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: Icon(Icons.list_rounded),
                        )
                      ],
                    ),
                    Wrap(children: [
                      buildPaymentList(
                          paymentList, _height, _width, themeProvider)
                    ]),
                    //Column( children: currentMonthPayments(paymentBox.values.toList(), context)),

                    // child: GridView.count(
                    //   crossAxisCount: 3,
                    //   childAspectRatio: 0.72,
                    //   children: [
                    //     serviceWidget("house", "House\n", themeProvider),
                    //     serviceWidget("food_1", "Food\n", themeProvider),
                    //     serviceWidget("train", "Transport\n", themeProvider),
                    //     serviceWidget("education", "Education\n", themeProvider),
                    //     serviceWidget("car", "Car\n", themeProvider),
                    //     serviceWidget("bulb", "Electricity\n", themeProvider),
                    //     serviceWidget("fitness", "Fitness\n", themeProvider),
                    //     serviceWidget("piggy_bank", "Savings\n", themeProvider),
                    //     serviceWidget("clothes", "Clothes\n", themeProvider),
                    //     serviceWidget("fun", "Fun\n", themeProvider),
                    //     serviceWidget(
                    //         "entertainment", "Entertainment\n", themeProvider),
                    //     serviceWidget("more_icon", "More\n", themeProvider),
                    //   ],
                    // ),
                  ],
                ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar(ThemeProvider themeProvider) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
      child: PreferredSize(
        preferredSize: Size(0, 150),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
              decoration: BoxDecoration(
                color: themeProvider.themeMode().navBarColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Quick Search Payments',
                              hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'avenir'),
                              icon: Icon(CupertinoIcons.search,
                                  color: Colors.grey[600])),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column serviceWidget(String img, String name, ThemeProvider themeProvider) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: themeProvider.themeMode().gradient,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
                // Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/$img.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget buildPaymentList(List<dynamic> paymentList, double _height,
      double _width, ThemeProvider themeProvider) {
    if (paymentList != null) {
      return LimitedBox(
        child: Container(
          //height: _height * 0.65,
          width: _width,
          decoration: BoxDecoration(
            color: themeProvider.themeMode().blendBackgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), topLeft: Radius.circular(0)),
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paymentList.length,
            itemBuilder: (context, index) {
              final paymentItem = paymentList[index];
              if (paymentItem != null) {
                return Container(
                  padding: new EdgeInsets.all(10),
                  //elevation: 0,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode().blendBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                          color: themeProvider.themeMode().navBarColor),
                    ),
                  ),
                  margin: new EdgeInsets.all(0),
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                        onLongPress: () {},
                        leading: Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeProvider
                                .categoryIcon(paymentItem.category)
                                .color,
                          ),
                          child: Icon(
                            themeProvider
                                .categoryIcon(paymentItem.category)
                                .icon,
                            size: 30,
                          ),
                        ),

                        // Checkbox(
                        //     value: paymentItem.isChecked,
                        //     onChanged: (bool value) {
                        //       setState(() {
                        //         paymentItem.isChecked = value;
                        //       });
                        //     }),
                        isThreeLine: false,
                        dense: true,
                        //font change
                        contentPadding: EdgeInsets.all(1),
                        title: Text(paymentItem.title,
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 17,
                                fontWeight: FontWeight.w700)),
                        subtitle: Container(
                          child: Text(
                              paymentItem.deadline.day.toString() +
                                  ' ' +
                                  monthName(paymentItem.deadline.month),
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),

                        trailing: Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Wrap(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                              paymentItem.cost
                                                      .truncate()
                                                      .toString() +
                                                  ' SEK ',
                                              style: TextStyle(
                                                  fontFamily: 'avenir',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: _width * 0.019,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                        // onChanged: (bool val) {
                        //   itemChange(val, index);
                        // }
                      ),
                    ],
                  ),
                );
              }
              return Container(
                  //     child: Center(
                  //   child: Text(
                  //     "You have no paid bills, Either you got no bills\n or you gotta get to work!",
                  //     style: TextStyle(
                  //         fontFamily: "avenir",
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // )
                  );
            },
          ),
        ),
      );
    } else
      return Container();
  }

  // Container avatarWidget(String img, Text textWidget,
  //     ThemeProvider themeProvider, List<Color> statusColor) {
  //   var _width = MediaQuery.of(context).size.width;
  //   var _height = MediaQuery.of(context).size.height;

  //   if (img == "paid") {
  //     return Container(
  //       margin: EdgeInsets.only(right: 20, left: 10),
  //       height: _height * 0.2,
  //       width: _width * 0.5,
  //       decoration: BoxDecoration(
  //         color: themeProvider.themeMode().appColor,
  //         boxShadow: themeProvider.themeMode().mainItemShadow,
  //         // gradient: LinearGradient(
  //         //     colors: themeProvider.themeMode().backgroundGradient),
  //         borderRadius: BorderRadius.all(Radius.circular(15)),

  //         // color: Colors.grey[900]
  //         //Color(0xfff1f3f6)
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Text(
  //             "Total " + totalPaidAmount().toString(),
  //             style: TextStyle(
  //                 color: Colors.amber[700],
  //                 fontSize: 20,
  //                 fontFamily: 'avenir',
  //                 fontWeight: FontWeight.w800),
  //           ),
  //           // Container(
  //           //   height: 120,
  //           //   width: 200,
  //           //   decoration: BoxDecoration(
  //           //     shape: BoxShape.circle,
  //           //
  //           //     //border: Border.all(color: Colors.grey[500], width: 2)
  //           //   ),
  //           //   child: Icon(
  //           //     CupertinoIcons.checkmark_alt_circle,
  //           //     color: Colors.white,
  //           //     size: 100,
  //           //   ),
  //           // ),
  //           // Text(
  //           //   name,
  //           //   style: TextStyle(
  //           //       fontSize: 13,
  //           //       fontFamily: 'avenir',
  //           //       fontWeight: FontWeight.w700),
  //           // ),
  //           textWidget,
  //         ],
  //       ),
  //     );
  //   }
  //   if (img == "missed") {
  //     return Container(
  //       margin: EdgeInsets.only(right: 20, left: 10),
  //       height: _height * 0.2,
  //       width: _width * 0.3,
  //       decoration: BoxDecoration(
  //         color: themeProvider.themeMode().appColor,
  //         //  boxShadow: themeProvider.themeMode().mainItemShadow,
  //         // gradient: LinearGradient(
  //         //     colors: themeProvider.themeMode().backgroundGradient),
  //         borderRadius: BorderRadius.all(Radius.circular(15)),

  //         // color: Colors.grey[900]
  //         //Color(0xfff1f3f6)
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Text(
  //             "Total " + totalMissedAmount().toString(),
  //             style: TextStyle(
  //                 color: Colors.amber[700],
  //                 fontSize: 20,
  //                 fontFamily: 'avenir',
  //                 fontWeight: FontWeight.w800),
  //           ),
  //           Container(
  //             height: 120,
  //             width: 200,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               //border: Border.all(color: Colors.grey[500], width: 2)
  //             ),
  //             child: Icon(
  //               CupertinoIcons.clock,
  //               color: Colors.white,
  //               size: 100,
  //             ),
  //           ),
  //           // Text(
  //           //   name,
  //           //   style: TextStyle(
  //           //       fontSize: 13,
  //           //       fontFamily: 'avenir',
  //           //       fontWeight: FontWeight.w700),
  //           // ),
  //           textWidget,
  //         ],
  //       ),
  //     );
  //   }
  //   if (img == "unpaid") {
  //     return Container(
  //       margin: EdgeInsets.only(right: 20, left: 10),
  //       height: _height * 0.2,
  //       width: _width * 0.3,
  //       decoration: BoxDecoration(
  //         color: themeProvider.themeMode().color,
  //         //boxShadow: themeProvider.themeMode().mainItemShadow,
  //         // gradient: LinearGradient(
  //         //     colors: themeProvider.themeMode().backgroundGradient),
  //         borderRadius: BorderRadius.all(Radius.circular(15)),

  //         // color: Colors.grey[900]
  //         //Color(0xfff1f3f6)
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Text(
  //             "Total " + totalUnPaidAmount().toString(),
  //             style: TextStyle(
  //                 color: Colors.amber[700],
  //                 fontSize: 14,
  //                 fontFamily: 'avenir',
  //                 fontWeight: FontWeight.w800),
  //           ),
  //           Container(
  //             height: 120,
  //             width: 200,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               //border: Border.all(color: Colors.grey[500], width: 2)
  //             ),
  //             child: Icon(
  //               CupertinoIcons.calendar,
  //               color: Colors.white,
  //               size: 29,
  //             ),
  //           ),
  //           // Text(
  //           //   name,
  //           //   style: TextStyle(
  //           //       fontSize: 13,
  //           //       fontFamily: 'avenir',
  //           //       fontWeight: FontWeight.w700),
  //           // ),
  //           textWidget,
  //         ],
  //       ),
  //     );
  //   }
  // }
}
