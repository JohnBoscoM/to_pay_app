import 'package:flutter/foundation.dart';

enum PaymentDateStatus { PaymentWeek, PaymentOverdue, PaymentNotOverdue }

class PaymentItem {
  String name;
  int cost;
  DateTime deadline;
  PaymentDateStatus paymentDateStatus;

  PaymentItem(String name, int cost, DateTime deadline) {
    this.name = name;
    this.cost = cost;
    this.deadline = deadline;
  }
}
