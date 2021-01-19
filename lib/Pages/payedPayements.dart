import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/paymentItem.dart';

import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';

class PayedPaymentsPage extends StatefulWidget {
  @override
  _PayedPaymentsPageState createState() => _PayedPaymentsPageState();
}

class _PayedPaymentsPageState extends State<PayedPaymentsPage> {
  AllPaymentsList pl = new AllPaymentsList();
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(      
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                  SizedBox(width: width, height: height *0.2 ,
                  child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/hugo-payed-bills.png"), alignment: Alignment.centerRight),
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent[700],Colors.green[200]],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                  child: Container(                
                    height: height * 0.2,
                    width: width,
                   alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Left To Pay:",
                      style: TextStyle(fontSize: 15, fontFamily: "avenir", color: Colors.white),
                      textAlign: TextAlign.left),
                      Text("6522 kr",
                      style: TextStyle(fontSize: 30, fontFamily: "avenir", color: Colors.white),
                      textAlign: TextAlign.center,),
                      ],
                  ),
                  ),
                ),
                  ),

                //Padding(padding: new EdgeInsets.all(0)),
                Column(
                  children: <Widget>[
                    
                    Container(
                      padding: EdgeInsets.only(left: 50,top: 30),
                      width: width,
                      decoration: BoxDecoration(
                        
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20), topLeft: Radius.circular(20),
                      ),
                      ),
                      child:Text("Payed Bills",
                        style: TextStyle(fontSize: 25, fontFamily: "avenir"),
                        textAlign: TextAlign.left
                        ),
                    ),                
                  ],
                ),
                buildList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(30)),
        ),
        child: ListView.builder(
          itemCount: pl.payments.length,
          itemBuilder: (context, index) {
            return Container(
              margin: new EdgeInsets.only(
                  left: 20.0, top: 0, right: 20.0, bottom: 0),
              child: new Container(
                padding: new EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: Checkbox(
                        activeColor: Colors.greenAccent[700],
                          value: pl.payments[index].isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              pl.payments[index].isChecked = value;
                            });
                          }),
                      isThreeLine: false,
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(1),
                      title: Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "avenir",
                            letterSpacing: 0.5),
                        textAlign: TextAlign.left,
                      ),
                      subtitle: Container(
                        child: Text(
                          pl.payments[index].deadline
                              .toString()
                              .substring(0, 10),
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "ubuntu",
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      trailing: Text(
                        pl.payments[index].cost.toString() + " kr",
                        style: TextStyle(
                            color: Colors.greenAccent[700],
                            fontSize: 16,
                            fontFamily: "ubuntu",
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5),
                      ),

                      // onChanged: (bool val) {
                      //   itemChange(val, index);
                      // }
                    ),
                  ],
                ),
              ),
            );
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
