

import 'package:flutter/cupertino.dart';
import 'package:to_pay_app/View/Payment/missedPayments.dart';
import 'package:to_pay_app/View/Payment/paidPayements.dart';
import 'package:to_pay_app/View/Payment/unpaidPayments.dart';

Widget openMissedPaymentsPage(){
    return MissedBillsPage();
}
Widget openUnpaidPaymentsPage(){
    return UnPaidPaymentsPage();
}
Widget openPaidPaymentsPage(){
    return PaidBillsPage();
}