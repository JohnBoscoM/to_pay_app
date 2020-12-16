import 'package:to_pay_app/budget/payments/paymentItem.dart';
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
        body: Container(
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
                      activeColor: Colors.grey[700],
                      dense: true,
                      //font change
                      title: new Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      ),
                      subtitle: Container(
                        child: Text(
                            pl.payments[index]
                                .deadline
                                .toString()
                                .substring(0, 10),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5)),
                      ),
                      value: true, //payments[index].isChecked,
                      secondary: Icon(
                        Icons.electrical_services_rounded,
                        size: 30,
                      ),
                      onChanged: (bool val) {
                        // itemChange(val, index);
                      })
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
