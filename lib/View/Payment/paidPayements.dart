import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:to_pay_app/View/CustomWidgets/CustomCheckbox.dart';
import 'package:to_pay_app/helpers/calendar.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_pay_app/models/user.dart';

class PaidBillsPage extends StatefulWidget {
  @override
  _PaidBillsPageState createState() => _PaidBillsPageState();
}

class _PaidBillsPageState extends State<PaidBillsPage> {
  final paymentBox = Hive.box('paymentBox');

  @override
  void initState() {
    super.initState();
  }

  bool checkBoxValue = false;
  // final userBox = await Hive.openBox('user');
  //final paymentItemBox = await Hive.openBox('user');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                //Padding(padding: new EdgeInsets.all(0)),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 30),
                      width: width,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode().blendBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      /*
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text("All Bills",
                              style:
                                  TextStyle(fontSize: 22, fontFamily: "avenir"),
                              textAlign: TextAlign.center),
                        ),

                         */
                    )
                  ],
                ),
                //buildSearchBar(themeProvider),
                buildPaidList(height, width, themeProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar(ThemeProvider themeProvider) {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30, bottom: 40),
      decoration: BoxDecoration(
        color: themeProvider.themeMode().searchBarColor,
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: themeProvider.themeMode().textColor),
                      icon: Icon(CupertinoIcons.search,
                          color: themeProvider.themeMode().textColor)),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildPaidList(
      double height, double width, ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(0)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if (paymentItem != null) {
              if (paymentItem.isChecked == false) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Icon(CupertinoIcons.delete_solid,
                          size: 32, color: Colors.black38),
                    ),
                  ),
                  key: Key(paymentItem.toString()),
                  onDismissed: (direction) {
                    paymentBox.delete(index);
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: Text(paymentItem.title + " has been removed"),
                    ));
                  },
                  child: new Container(
                    padding: new EdgeInsets.all(15),
                    //elevation: 0,
                    decoration: BoxDecoration(
                      //color: themeProvider.themeMode().color,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: themeProvider.themeMode().borderColor),
                      // boxShadow: themeProvider.themeMode().itemShadow
                    ),
                    margin: new EdgeInsets.all(10),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.350,
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomCheckbox(
                                                  paymentItem.isChecked,
                                                  23.0,
                                                  18.0,
                                                  Colors.blue,
                                                  Colors.white),
                                              SizedBox(
                                                width: 20,
                                              )
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
                  ),
                );
              }
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
  }

  void itemChange(bool val, int index) {
    setState(() {
      paymentBox.values.toList()[index].isChecked = val;
    });
  }
}
