import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_pay_app/View/CustomWidgets/CustomCheckbox.dart';
import 'package:to_pay_app/View/Payment/EditPaymentPage.dart';
import 'package:to_pay_app/controller/paymentController.dart';
import 'package:to_pay_app/helpers/calendar.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'file:///C:/Users/John%20Bosco%20Matanda/Documents/App%20Development/to_pay_app/lib/View/payment/allPayments.dart';
import 'package:to_pay_app/models/bill.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends State<CalendarPage> {
  PaymentController paymentController = new PaymentController();
  final paymentBox = Hive.box('paymentBox');
  var _selectedDay = DateTime.now();
  List<dynamic> paymentList;

  CalendarController _calendarController;
  Map<DateTime, List> _event = new Map();

  List selectedPaymentItemList;

  @override
  void initState() {
    super.initState();
    paymentList = paymentController.getAllPaymentItems();
    _calendarController = CalendarController();
    selectedPaymentItemList = getDateItemList(_selectedDay);
    _event = getEvent(paymentList);

    //_datePaymentItemList = getDateItemList(paymentBox,_selectedDay);
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  // Map<List<DateTime>, List> fetchEvents(DateTime selectedDate) {
  //   var event = new Map<DateTime, List>();
  //   List<dynamic> billItems = new List<dynamic>();
  //   List<DateTime> dates = new List<DateTime>();
  //   paymentBox.toMap().forEach((key, value) {
  //     dates.add(value.deadline);
  //       billItems.add(value);
  //   });
  //   event = {selectedDate: billItems};
  //
  //   return event;
  // }

  List<dynamic> getDateItemList(DateTime selectedDate) {
    var dateItemList = <dynamic>[];
    var items = paymentList;
    items.forEach((value) {
      if (value.deadline.toString().substring(0, 10) ==
          selectedDate.toString().substring(0, 10)) dateItemList.add(value);
    });
    return dateItemList;
  }

  void _onDaySelected(DateTime day) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedPaymentItemList = getDateItemList(day);
    });
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

    TextStyle weekendStyle(FontWeight fontWeight) {
      return TextStyle(
          color: Colors.red[200], fontWeight: fontWeight, fontFamily: "avenir");
    }

    ;
    return Scaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
      // appBar: AppBar(
      //   backgroundColor: themeProvider.themeMode().color,
      //   elevation: 0,
      //   leadingWidth: _width,
      //   leading: Container(
      //       width: _width,
      //       padding: EdgeInsets.only(top: 20, left: 20),
      //       child: Text(
      //         "Calendar",
      //         style: TextStyle(
      //             color: themeProvider.themeMode().textColor,
      //             fontSize: 25,
      //             fontWeight: FontWeight.w800,
      //             fontFamily: "avenir"),
      //       )),
      //   // actions: [
      //   //   Icon(
      //   //     Icons.notifications_none_rounded,
      //   //     size: 30,
      //   //     color:  themeProvider.themeMode().textColor,
      //   //   )
      //   // ],
      // ),
      body: Container(
        color: themeProvider.themeMode().navBarColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _height * 0.03),
              TableCalendar(
                events: _event,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  markersColor: Colors.brown[600],
                  weekdayStyle: dayStyle(FontWeight.normal),
                  weekendStyle: weekendStyle(FontWeight.normal),
                  selectedColor: Colors.brown[400],
                  todayColor: Colors.blueAccent,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: themeProvider.themeMode().textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16),
                    weekendStyle: TextStyle(
                        color: Colors.red[200],
                        fontWeight: FontWeight.bold,
                        fontFamily: "avenir",
                        fontSize: 16)),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                      fontSize: 21,
                      fontFamily: "avenir",
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700]),
                ),
                calendarController: _calendarController,
                //events: _datePaymentItemList,
                onDaySelected: (date, event, holiday) {
                  _selectedDay = date;
                  _onDaySelected(date);
                },
                builders: CalendarBuilders(
                    markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (_event.isNotEmpty) {
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 1,
                        child: _buildEventsMarker(date, events),
                      ),
                    );
                  }
                  return children;
                }),
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
                          padding: EdgeInsets.only(top: 30, left: 0),
                          child: Text(
                            _selectedDay.day.toString() +
                                " " +
                                monthName(_selectedDay.month),
                            style: TextStyle(
                                color: themeProvider.themeMode().textColor,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
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

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.grey[700]
            : _calendarController.isToday(date)
                ? Colors.red[300]
                : Colors.brown[300],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
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
          itemCount: selectedPaymentItemList.length,
          itemBuilder: (context, index) {
            final paymentItem = selectedPaymentItemList[index];
            return Container(
              margin: new EdgeInsets.only(
                  left: 20.0, top: 0, right: 20.0, bottom: 15),
              child: new Container(
                decoration: BoxDecoration(
                  color: themeProvider.themeMode().blendBackgroundColor,
                  border: Border(
                    bottom: BorderSide(
                        color: themeProvider.themeMode().navBarColor),
                  ),
                ),
                padding: new EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      // onLongPress: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EditPaymentPage()),
                      //   );
                      // },
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
                      contentPadding: EdgeInsets.all(0),
                      title: Text(paymentItem.title,
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                      subtitle: Container(
                        child: Text(
                            paymentItem.deadline.day.toString() +
                                ' ' +
                                monthName(paymentItem.deadline.month),
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 13,
                                fontWeight: FontWeight.w700)),
                      ),

                      trailing: Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.350,
                              child: Wrap(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            paymentItem.cost
                                                    .truncate()
                                                    .toString() +
                                                ' SEK ',
                                            style: TextStyle(
                                                fontFamily: 'avenir',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          CustomCheckbox(
                                              paymentItem.isChecked,
                                              26.0,
                                              18.0,
                                              Colors.blueAccent,
                                              Colors.white),
                                          SizedBox(
                                            width: 0,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))),

                      // onChanged: (bool val) {
                      //   itemChange(val, index);
                      // }
                    ),
                  ],
                ),
              ),
            );
            return Container();
          },
        ),
      ),
    );
  }
}
