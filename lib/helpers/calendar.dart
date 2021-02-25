
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



// List<dynamic> getDateItemList(Box paymentBox, DateTime selectedDate){
//   var paymentlist = new List<dynamic>();
//   var event = new Map<DateTime,List<dynamic>>();
//   paymentBox.toMap().forEach((key, value) {
//     if (value.deadline == selectedDate)
//       paymentlist.add(value);
//   });
//   return paymentlist;
// }