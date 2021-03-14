import 'package:flutter/cupertino.dart';

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

import 'EditPaymentPage.dart';

class AllPaymentsPage extends StatefulWidget {
  @override
  _AllPaymentsPageState createState() => _AllPaymentsPageState();
}

class _AllPaymentsPageState extends State<AllPaymentsPage> {
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
          child: buildList(themeProvider),
        ),
      ),
    );
  }
 Widget buildSearchBar(ThemeProvider themeProvider){
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30, bottom: 30 ),
      decoration: BoxDecoration(
        color: themeProvider.themeMode().searchBarColor,
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex:1,
            child: Padding(
              padding: EdgeInsets.only(left:20),
              child:TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: themeProvider.themeMode().textColor),
                icon: Icon(CupertinoIcons.search, color: themeProvider.themeMode().textColor)
              ),
            ),
            )
          ),
        ],
      ),
    );
 }
  Widget buildList(ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          boxShadow: themeProvider.themeMode().mainItemShadow,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(0)),
        ),
        child: ListView.builder(
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if(paymentItem!= null) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                key: Key(paymentItem.toString()),
                background: Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                      CupertinoIcons.delete_solid, size: 32, color: Colors.red),
                ),
                secondaryBackground: Container(
                    padding: EdgeInsets.only(right: 30),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text("Edit", style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      fontFamily: "avenir",))
                ),
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
                    color: themeProvider
                        .themeMode()
                        .color,

                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  margin: new EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditPaymentPage()),
                          );
                        },
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
                          child: Container(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.235, child: Row(
                            children: [
                              Text(
                                paymentItem.cost.truncate().toString() + " kr",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontFamily: "avenir",
                                    fontWeight: FontWeight.w800,
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
            return Container();
            }

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
