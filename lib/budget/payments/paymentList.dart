import 'package:to_pay_app/budget/payments/paymentItem.dart';

class PaymentList{
List<PaymentItem> payments = [
    PaymentItem("Rent", 3202, DateTime.now(),false),
    PaymentItem("Telia Bredband 500", 379, DateTime.now(),false),
    PaymentItem("Unionen", 235, DateTime.now(), false),
    PaymentItem("Unionen A-Kassa", 101, DateTime.now(), false),
    PaymentItem("Borås Elnät", 359, DateTime.now(), false),
    PaymentItem("Fortum", 89, DateTime.now(), false),
    PaymentItem("Netflix", 159, DateTime.now(), false),
    PaymentItem("Disney Plus", 69, DateTime.now(), false),
    PaymentItem("7H Trafikskola", 1410, DateTime.now(), false),
  ];
}

