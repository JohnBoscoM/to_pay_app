import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

List<Widget> currentMonthPayments(List<dynamic> paymentList, context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  var monthPayments = <Widget>[];
  var currentMonth = DateTime.now().month;
  try {
    paymentList.forEach((payment) {
      if (currentMonth == payment.deadline.month) {
        var paymentDisplayItem = Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            //color: themeProvider.themeMode().color,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.grey.shade300),
            // boxShadow: themeProvider.themeMode().itemShadow
          ),
          child: ListTile(
            leading: Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(right: 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeProvider.categoryIcon(payment.category).color,
              ),
              child: Icon(
                themeProvider.categoryIcon(payment.category).icon,
                size: 30,
              ),
            ),
            title: Text(payment.title,
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
            subtitle: Text(payment.deadline.toString(),
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 13,
                    fontWeight: FontWeight.w700)),
            trailing: Text(
              payment.cost.toString() + ' SEK',
              style: TextStyle(
                  fontFamily: 'avenir',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        );
        monthPayments.add(paymentDisplayItem);
      }
    });
  } catch (Exception) {}
  return monthPayments;
}
