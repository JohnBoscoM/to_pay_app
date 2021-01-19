import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'package:to_pay_app/Pages/allPayments.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  AllPaymentsList pl = new AllPaymentsList();
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents = new List<String>();
  DateTime _selectedDay;

  final Map<DateTime, List> _events = {
    DateTime(2020, 5, 7): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2020, 5, 9): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 10): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2020, 5, 25): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2020, 6, 6): [
      {'name': 'Event A', 'isDone': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Calendar(
                startOnMonday: true,
                weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: _events,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.yellow,
                eventColor: Colors.grey,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    _selectedEvents.add("Hyra");
    _selectedEvents.add("Nätverk");
    _selectedEvents.add("Bil");
    _selectedEvents.add("Netflix");
    _selectedEvents.add("Klarna: IKEA");
    //_selectedEvents.clear();
    return Expanded(
      child: ListView.builder(
        itemCount: pl.payments.length,
        itemBuilder: (context, index) {
          return Card(
            shadowColor: Colors.transparent,
            borderOnForeground: true,
            margin: new EdgeInsets.only(left: 20.0, top: 10, right: 20.0,bottom:10),
            color: Color(0xfff1f3f6),
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new CheckboxListTile(
                      isThreeLine: false,
                      activeColor: Colors.black,                   
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(1),
                      title: Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            color:Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "avenir",
                            letterSpacing: 0.5),
                        textAlign: TextAlign.left,
                      ),
                      subtitle: Container(
                        child: Text(
                          "Dagar kvar: 12",
                            // pl.payments[index]
                            //     .deadline
                            //     .toString()
                            //     .substring(0, 10),
                          style: TextStyle(
                              color:Colors.grey[600],
                              fontSize: 13,
                              fontFamily: "ubuntu",
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5),
                                textAlign: TextAlign.left,
                                ),
                      ),
                      value: true, //payments[index].isChecked,
                      secondary: Container(
                        child: Text(
                        pl.payments[index].cost.toString()+" kr",
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 16,
                          fontFamily: 'ubuntu',
                          fontWeight: FontWeight.w600,
                          fontFamilyFallback: <String>[

                          ],
                          letterSpacing: 0.5),
                          
                        ),
                      ),    
                      onChanged: (bool val) {
                        // itemChange(val, index);
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
