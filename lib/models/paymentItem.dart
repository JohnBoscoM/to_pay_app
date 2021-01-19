import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'paymentItem.g.dart';

@HiveType(typeId: 12)
enum PaymentDateStatus { PayedPayment, UpcomingPayment, MissedPayment }

@HiveType(typeId: 13)
enum Category {
  House,
  Food,
  Elecricity,
  Transport,
  Car,
  Education,
  Fitness,
  Shopping,
  Entertainment
}

@HiveType(typeId: 11)
class PaymentItem {
  @HiveField(0)
  String title;
  @HiveField(1)
  double cost;
  @HiveField(2)
  DateTime deadline;
  @HiveField(3)
  PaymentDateStatus paymentDateStatus;
  @HiveField(4)
  bool isChecked;
  @HiveField(5)
  bool isPayed;
  @HiveField(6)
  Category category;

  PaymentItem(String title, double cost, DateTime deadline, bool isChecked,
      PaymentDateStatus paymentDateStatus, bool isPayed, Category category) {
    this.title = title;
    this.cost = cost;
    this.deadline = deadline;
    this.isChecked = isChecked;
    this.paymentDateStatus = paymentDateStatus;
  }
}
