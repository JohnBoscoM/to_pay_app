import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_pay_app/View/Payment/allPayments.dart';
import 'package:to_pay_app/View/Payment/missedPayments.dart';
import 'package:to_pay_app/View/Payment/paidPayements.dart';
import 'package:to_pay_app/View/Payment/unpaidPayments.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

String getRecurrenceIndexLabel(index) {
  if (index == 0) {
    return "Quarterly";
  }
  if (index == 1) {
    return "Monthly";
  }
  if (index == 2) {
    return "Weekly";
  }
  return "";
}

String getIndexLabel(index) {
  if (index == 0) {
    return "Paid";
  }
  if (index == 1) {
    return "Unpaid";
  }
  if (index == 2) {
    return "Missed";
  }
  return "";
}
