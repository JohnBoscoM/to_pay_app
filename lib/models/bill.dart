import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'bill.g.dart';

enum Recurrence {
  QUATERLY,
  MONTHLY,
  WEEKDLY,
  NEVER,
}

class BillDateStatus {
  List<String> paymentStatus = [
    'UpComing',
    'Payed',
    'Missed',
  ];
}

class Category {
  List<String> categories = [
    'Household',
    'Food',
    'Car',
    'Electricity',
    'Fitness',
    'Education',
    'Shopping',
    'Entertainment',
    //  'Broadband'
    'Other'
  ];
}

@HiveType(typeId: 100)
class BillItem {
  @HiveField(0)
  String title;
  @HiveField(1)
  double cost;
  @HiveField(2)
  DateTime deadline;
  @HiveField(3)
  String billDateStatus;
  @HiveField(4)
  bool isChecked;
  @HiveField(5)
  bool isPayed;
  @HiveField(6)
  String category;
  @HiveField(40)
  int recurrence;

  BillItem(String title, double cost, DateTime deadline, bool isChecked,
      String billDateStatus, bool isPayed, String category, int recurrence) {
    this.title = title;
    this.cost = cost;
    this.deadline = deadline;
    this.isChecked = isChecked;
    this.billDateStatus = billDateStatus;
    this.category = category;
    this.recurrence = recurrence;
  }
}
