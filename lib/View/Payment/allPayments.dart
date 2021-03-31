import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
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
      appBar: AppBar(
        leading: Text("Search"),
      ),
      body: SafeArea(
        child: Stack(children:[buildList(themeProvider),buildSearchBar(themeProvider)]
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
         // boxShadow: themeProvider.themeMode().mainItemShadow,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(0)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if(paymentItem!= null) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                key: Key(paymentItem.toString()),
                background: Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(right: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                    child: Icon(
                        CupertinoIcons.delete_solid, size: 32, color: Colors.black38),
                  ),
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
                  paymentBox.deleteAt(index);
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text(paymentItem.title + " has been removed"),
                  ));
                },
                child: new Container(
                  padding: new EdgeInsets.all(15),
                  //elevation: 0,
                  decoration:   BoxDecoration(
                    //color: themeProvider.themeMode().color,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  //  border: Border.all(color: themeProvider.themeMode().borderColor),
                    // boxShadow: themeProvider.themeMode().itemShadow
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
                        title: Text(paymentItem.title, style: TextStyle(fontFamily:'avenir', fontSize: 17, fontWeight: FontWeight.w800)),
                        subtitle: Container(
                          child: Text(paymentItem.deadline.day.toString() + ' ' +monthName(paymentItem.deadline.month), style: TextStyle(fontFamily:'avenir', fontSize: 13, fontWeight: FontWeight.w700)),
                        ),

                        trailing: Text( paymentItem.cost.truncate().toString() + ' SEK ', style: TextStyle(fontFamily:'avenir', fontSize: 20, fontWeight: FontWeight.w700),),


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
