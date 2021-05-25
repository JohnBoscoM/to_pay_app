import 'package:flutter/material.dart';
import 'package:to_pay_app/models/PaymentBusiness.dart';

class PaymentController {
  PaymentBusiness paymentBusiness = new PaymentBusiness();
  List<dynamic> getPaymentList(int index) {
    return paymentBusiness.getPaymentList(index);
  }

  void deletePaymentItem(int index) {
    paymentBusiness.deletePaymentItem(index);
  }

  List<dynamic> getAllPaymentItems() {
    return paymentBusiness.getAllPaymentItems();
  }

  String getCurrencySymbol(BuildContext context) {
    paymentBusiness.currencySymbol(context);
  }
}
