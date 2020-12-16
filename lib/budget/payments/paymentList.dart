import 'package:to_pay_app/budget/payments/paymentItem.dart';

class PaymentList{
List<PaymentItem> payments = [
    PaymentItem("Hyra", 3202, DateTime.now(),false),
    PaymentItem("Telia", 379, DateTime.now(),false),
    PaymentItem("El", 101, DateTime.now(), false)
  ];
}

