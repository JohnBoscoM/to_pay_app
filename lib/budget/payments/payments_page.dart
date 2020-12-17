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
                      activeColor: Colors.red,
                    
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(3),
                      title: Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            //fontFamily: FontFamily.,
                            letterSpacing: 0.5),
                            textAlign: TextAlign.center,
                      ),
                      subtitle: Container(
                        child: Text(
                          "Days left: 12",
                            // pl.payments[index]
                            //     .deadline
                            //     .toString()
                            //     .substring(0, 10),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                                textAlign: TextAlign.center,
                                ),
                      ),
                      value: true, //payments[index].isChecked,
                      secondary: Container(
                        child: Text(
                        pl.payments[index].cost.toString()+" kr",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontFamilyFallback: <String>[
                              'Noto Sans CJK SC',
                              'Noto Color Emoji',
                          ],
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                          
                        ),
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
