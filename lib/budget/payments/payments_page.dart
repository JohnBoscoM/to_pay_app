import 'package:to_pay_app/budget/payments/paymentItem.dart';
import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  List<PaymentItem> payments = [
    PaymentItem("Hyra", 3202, DateTime.now()),
    PaymentItem("Telia", 379, DateTime.now()),
    PaymentItem("El", 101, DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              title: Text(payments[index].name),
            ),
          );
        },
      ),
    );
  }
}
