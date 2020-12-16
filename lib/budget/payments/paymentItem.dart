import 'package:flutter/foundation.dart';

enum PaymentDateStatus { PaymentWeek, PaymentOverdue, PaymentNotOverdue }

class PaymentItem {
  String title;
  int cost;
  DateTime deadline;
  PaymentDateStatus paymentDateStatus;
  bool isChecked;

  PaymentItem(String title, int cost, DateTime deadline, bool isChecked) {
    this.title = title;
    this.cost = cost;
    this.deadline = deadline;
    this.isChecked = isChecked;
  }
}
