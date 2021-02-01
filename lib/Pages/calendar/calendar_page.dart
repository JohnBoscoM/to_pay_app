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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    TextStyle dayStyle(FontWeight fontWeight) {
      return TextStyle(
          color: themeProvider.themeMode().textColor,
          fontWeight: fontWeight,
          fontFamily: "avenir");
    }

    ;
    return Scaffold(
      backgroundColor: themeProvider.themeMode().color,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: themeProvider.themeMode().backgroundGradient,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _height * 0.03),
              TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  weekdayStyle: dayStyle(FontWeight.normal),
                  weekendStyle: dayStyle(FontWeight.normal),
                  selectedColor: Colors.deepPurpleAccent[100],
                  todayColor: Colors.red[600],
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: themeProvider.themeMode().textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16),
                    weekendStyle: TextStyle(
                        color: themeProvider.themeMode().textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16)),
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
                width: _width,
                height: _height * 0.55,
                decoration: BoxDecoration(
                  color: themeProvider.themeMode().blendBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50, left: 0),
                          child: Text(
                            "31 January",
                            style: TextStyle(
                                color: themeProvider.themeMode().textColor,
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        buildList(themeProvider)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ListView.builder(
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            return Container(
              margin: new EdgeInsets.only(
                  left: 20.0, top: 0, right: 20.0, bottom: 15),
              child: new Container(
                decoration: BoxDecoration(
                  color: themeProvider.themeMode().color,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: new EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeProvider
                              .categoryIcon(paymentItem.category)
                              .color,
                        ),
                        child: Icon(
                          themeProvider.categoryIcon(paymentItem.category).icon,
                          size: 30,
                        ),
                      ),
                      isThreeLine: false,
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(1),
                      title: Text(
                        paymentItem.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: "avenir",
                            letterSpacing: 0.5),
                        textAlign: TextAlign.left,
                      ),
                      subtitle: Container(
                        child: Text(
                          paymentItem.deadline.toString().substring(0, 10),
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "avenir",
                              fontWeight: FontWeight.w600,

                              letterSpacing: 0.5),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      trailing: Flexible(
                        flex: 1,
                      fit: FlexFit.loose,
                      child:Container( width: MediaQuery.of(context).size.width * 0.32, child:Row(
                        children: [
                          Text(
                            paymentItem.cost.toString() + " kr",
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontFamily: "avenir",
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5),
                          ),

                          Checkbox(
                              value: paymentItem.isChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  paymentItem.isChecked = value;
                                });
                              }),
                        ],
                      ),
                      ),
                      ),

                      // onChanged: (bool val) {
                      //   itemChange(val, index);
                      // }
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
