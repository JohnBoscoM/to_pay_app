import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_pay_app/models/user.dart';

class MissedBillsPage extends StatefulWidget {
  @override
  _MissedBillsPageState createState() => _MissedBillsPageState();
}

class _MissedBillsPageState extends State<MissedBillsPage> {
  final paymentBox = Hive.box('paymentBox');

  @override
  void initState() {
    super.initState();
  }

  AllPaymentsList pl = new AllPaymentsList();
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
                buildList(themeProvider,height,width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(ThemeProvider themeProvider, height, width) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(0)),
        ),
        child: ListView.builder(
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if (paymentItem.deadline.isBefore(new DateTime.now()) &&
                paymentItem.isChecked == false) {
              return Dismissible(
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
                    color: themeProvider.themeMode().color,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
                        title: Text(
                          paymentItem.title,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: "avenir",
                              letterSpacing: 0.5),
                          textAlign: TextAlign.left,
                        ),
                        subtitle: Container(
                          child: Text(
                            paymentItem.deadline.toString().substring(0, 10),
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "avenir",
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        trailing: Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            child: Row(
                              children: [
                                Text(
                                  paymentItem.cost.toString() + " kr",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontFamily: "avenir",
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5),
                                ),
                                Checkbox(
                                    value: paymentItem.isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        paymentItem.isChecked = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),

                        // onChanged: (bool val) {
                        //   itemChange(val, index);
                        // }
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
                child: Center(

              child: Text("You have no missed bills, Keep it up!",
              style: TextStyle(fontFamily: "avenir", fontSize: 16, fontWeight: FontWeight.bold),),
            ));
          },
        ),
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      pl.payments[index].isChecked = val;
    });
  }
}
