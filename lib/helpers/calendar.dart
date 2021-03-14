
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive/hive.dart';

String monthName(int monthValue){
  switch(monthValue){
    case 1: return "January";
    case 2: return "Febuary";
    case 3: return "Mars";
    case 4: return "April";
    case 5: return "May";
    case 6: return "June";
    case 7: return "July";
    case 8: return "August";
    case 9: return "September";
    case 10: return "October";
    case 11: return "November";
    case 12: return "December";
    default: return "";
  }
}
List<dynamic> getDatePayments(List<dynamic> paymentList, DateTime date){
  var datePayments = [];
    paymentList.forEach((payment) {
      if(date.toString().substring(0,10) == payment.deadline.toString().substring(0, 10)) {
        datePayments.add(payment);
      }
    });
    return datePayments;
}


Map<DateTime, List<dynamic>>getEvent(List<dynamic>paymentList){
  var dates = new List<DateTime>();

  var events = new Map<DateTime,List<dynamic>>();
      paymentList.forEach((payment) {
        dates.add(payment.deadline);
      });
      paymentList.forEach((payment) {
        dates.forEach((date) {
          if (date.toString().substring(0, 10) == payment.deadline.toString().substring(0, 10)) {
            events.addAll({date: getDatePayments(paymentList,date)});
          }
        });
      });
      return events;
}


