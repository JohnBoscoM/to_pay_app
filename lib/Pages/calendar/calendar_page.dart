import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'package:to_pay_app/Pages/allPayments.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  final paymentBox = Hive.box('paymentBox');
  CalendarController _calendarController;


  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextStyle dayStyle(FontWeight fontWeight) {
      return TextStyle(color: themeProvider
          .themeMode()
          .textColor, fontWeight: fontWeight,
        fontFamily: "avenir");
    };
    return Scaffold(
      backgroundColor: themeProvider.themeMode().color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  weekdayStyle: dayStyle(FontWeight.normal),
                  weekendStyle: dayStyle(FontWeight.normal),
                  selectedColor: themeProvider
                      .themeMode()
                      .selectedColor,
                  todayColor: Colors.red,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: themeProvider.themeMode().textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16),
                    weekendStyle: TextStyle(color: themeProvider.themeMode().textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16)
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    fontSize: 21,
                    fontFamily: "avenir",
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
                ),
                calendarController: _calendarController,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),

                  gradient: LinearGradient(
                      colors: themeProvider.themeMode().backgroundGradient,
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}