import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'bill.g.dart';

class BillDateStatus { 
  List<String> paymentStatus = [
    'UpComing',
    'Payed',
    'Missed',
  ]; }

class Category {
  List<String> categories = [
    'Accomodation',
    'Food',
    'Car',
    'Electricty',
    'Fitness',
    'Education',
    'Shopping',
    'Entertainment',
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

  BillItem(String title, double cost, DateTime deadline, bool isChecked,
      String billDateStatus, bool isPayed, String category) {
    this.title = title;
    this.cost = cost;
    this.deadline = deadline;
    this.isChecked = isChecked;
    this.billDateStatus = billDateStatus;
    this.category = category;
  }
}
