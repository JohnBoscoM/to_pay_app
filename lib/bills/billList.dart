import 'package:to_pay_app/bills/billItem.dart';
import 'package:flutter/material.dart';

class BillList {
  List<BillItem> bills = new List();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Home',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.black
    ),
  );
}
