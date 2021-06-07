import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class PaymentBusiness {
  final Box paymentBox = Hive.box('paymentBox');

  Box getPaymentDB() {
    return paymentBox;
  }

  List<dynamic> getPaymentList(int index) {
    if (index == 0) {
      return getPaidPaymentList(paymentBox.values.toList());
    }
    if (index == 1) {
      return getUnpaidPaymentList(paymentBox.values.toList());
    }
    if (index == 2) {
      return getMissedPaymentList(paymentBox.values.toList());
    }
    return <dynamic>[];
  }

  void deletePaymentItem(index) {
    print("Before " + paymentBox.length.toString());
    paymentBox.deleteAt(index);
    print("After " + paymentBox.length.toString());
  }

  List<dynamic> getAllPaymentItems() {
    return paymentBox.values.toList();
  }

  List<dynamic> getPaidPaymentList(List<dynamic> dataList) {
    var paymentList = <dynamic>[];
    dataList.forEach((item) {
      if (item.isChecked == true) {
        paymentList.add(item);
      }
    });
    return paymentList;
  }

  void getRecurrence(int index) {}

  List<dynamic> getUnpaidPaymentList(List<dynamic> dataList) {
    var paymentList = <dynamic>[];
    dataList.forEach((item) {
      if (item.isChecked == false) {
        paymentList.add(item);
      }
    });
    return paymentList;
  }

  List<dynamic> getMissedPaymentList(List<dynamic> dataList) {
    var paymentList = <dynamic>[];
    dataList.forEach((item) {
      if (item.deadline.isBefore(new DateTime.now()) &&
          item.isChecked == false) {
        paymentList.add(item);
      }
    });
    return paymentList;
  }

  String currencySymbol(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol;
    // print("CURRENCY SYMBOL ${format.currencySymbol}");
    // print("CURRENCY NAME ${format.currencyName}");
  }
}

int calculatePaidProcental(double totalSum, double totalPaidSum) {
  double paidFraction = totalPaidSum / totalSum;
  return (paidFraction * 100).truncate();
}

int calculateUnpaidProcental(double totalSum, double totalUnpaidSum) {
  double unPaidFraction = totalUnpaidSum / totalSum;
  return (unPaidFraction * 100).truncate();
}

int calculateMissedProcental(double totalSum, double totalMissedSum) {
  double missedFraction = totalMissedSum / totalSum;
  return (missedFraction * 100).truncate();
}
