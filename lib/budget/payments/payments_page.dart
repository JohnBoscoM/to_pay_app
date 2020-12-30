import 'package:to_pay_app/models/paymentItem.dart';

import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  PaymentList pl = new PaymentList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Chip(
              label: 
              Text(
              "Electricity",
              style: TextStyle(
              fontFamily: "avenir"
              )),
              backgroundColor: Colors.grey[200],
              //shape: StadiumBorder(side: BorderSide()),
              avatar: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.bolt,
                    color: Colors.black,
                  )),
            ),
            Chip(
              label: Text("HouseHold"),
              backgroundColor: Colors.grey[200],
              //shape: StadiumBorder(side: BorderSide()),
              avatar: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  )),
            ),
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget FilterChips() {}

  Widget buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: pl.payments.length,
        itemBuilder: (context, index) {
          return Card(
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new CheckboxListTile(
                      isThreeLine: false,
                      activeColor: Colors.black,
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(1),
                      title: Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "avenir",
                            letterSpacing: 0.5),
                        textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: pl.payments[index].isChecked,
                      secondary: Container(
                        child: Text(
                          pl.payments[index].cost.toString() + " kr",
                          
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontFamily: "ubuntu",
                              
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5),
                        ),
                      ),
                      onChanged: (bool val) {
                        itemChange(val, index);
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      pl.payments[index].isChecked = val;
    });
  }
}
