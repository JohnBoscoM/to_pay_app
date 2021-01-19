import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/allPayments.dart';
import 'package:to_pay_app/Pages/missedPayments.dart';
import 'package:to_pay_app/Pages/payedPayements.dart';
import 'package:to_pay_app/Pages/upcomingPayments.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/paymentItem.dart';

import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';

class PaymentsTabbedPage extends StatefulWidget {
  @override
  _PaymentsTabbedPageState createState() => _PaymentsTabbedPageState();
}

class _PaymentsTabbedPageState extends State<PaymentsTabbedPage>
    with SingleTickerProviderStateMixin {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
        

    if (datePicker != null && datePicker != _date) {
      setState(() {
        _date = datePicker;
      });
    }
  }

  TabController _controller;
  int _selectedIndex = 0;
  String dropdownValue = 'Rent';

  List<Widget> list = [
    Tab(text: "All"),
    Tab(text: "Upcoming"),
    Tab(text: "Payed"),
    Tab(text: "Missed"),
  ];
  AllPaymentsList pl = new AllPaymentsList();
  bool checkBoxValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var mediaQuery = MediaQuery.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('Bills'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            AllPaymentsPage(),
            UpcomingPaymentsPage(),
            PayedPaymentsPage(),
            MissedPaymentsPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _buildModal(themeProvider, mediaQuery, height);
          },
        ),
      ),
    );
  }

  Widget buildList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(30)),
        ),
        child: ListView.builder(
          itemCount: pl.payments.length,
          itemBuilder: (context, index) {
            return Container(
              margin: new EdgeInsets.only(
                  left: 20.0, top: 0, right: 20.0, bottom: 0),
              child: new Container(
                padding: new EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: Checkbox(
                          value: pl.payments[index].isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              pl.payments[index].isChecked = value;
                            });
                          }),
                      isThreeLine: false,
                      dense: true,
                      //font change
                      contentPadding: EdgeInsets.all(1),
                      title: Text(
                        pl.payments[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "avenir",
                            letterSpacing: 0.5),
                        textAlign: TextAlign.left,
                      ),
                      subtitle: Container(
                        child: Text(
                          pl.payments[index].deadline
                              .toString()
                              .substring(0, 10),
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "ubuntu",
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      trailing: Text(
                        pl.payments[index].cost.toString() + " kr",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontFamily: "ubuntu",
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5),
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

  Widget _buildModal(ThemeProvider themeProvider, MediaQueryData mediaQuery, double height) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: height,
           // padding: mediaQuery.viewInsets,
              decoration: BoxDecoration(
                color: themeProvider.themeMode().color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: _inputField(themeProvider));
        });
  }

  Widget _inputField(ThemeProvider themeProvider) {
    return Column(
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.only(top: 25, bottom: 10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.transparent))),
          child: Text(
            "Add Bill",
            style: TextStyle(fontSize: 25, fontFamily: "avenir"),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 350,
          padding: EdgeInsets.only(top: 20, left: 0, right: 10, bottom: 15),
          child: TextField(
            autofocus: true,
            // controller: usernameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.title_outlined),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
              border: OutlineInputBorder(borderRadius:  BorderRadius.all(Radius.circular(20))),
              labelText: "Title",
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 350,
          padding: EdgeInsets.only(top: 10, left: 0, right: 10, bottom: 20),
          child: TextField(
            keyboardType: TextInputType.number,
            //  controller: usernameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.payment_outlined),
                labelText: "Cost",
                hoverColor: Colors.red,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(20))
                )),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 350,
          padding: EdgeInsets.only(top: 10, left: 0, right: 10, bottom: 0),
          child: TextField(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                _selectDate(context);
              });
            },
            //  controller: usernameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText: "Deadline",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(borderRadius:  BorderRadius.all(Radius.circular(20)))),
          ),
        ),
        Container(
            width: 300,
            padding: EdgeInsets.only(top: 10),
            child: buildDropDownList()),

               RaisedButton(
          padding: EdgeInsets.only(top: 100, right: 50, left: 50),
          color: Colors.transparent,
          elevation: 0,
          onPressed: () {
            // createUser(
            //     usernameController.text, double.parse(incomeController.text));

  
          },
          textColor: Colors.white,
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: Colors.cyan[500],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "avenir"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDatePicker() {}
  Widget buildDropDownList() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 0),
      child: DropdownButton<String>(
        value: dropdownValue,
        //icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(fontSize: 18),
        underline: Container(
          height: 2,
          color: Colors.grey[200],
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Rent', 'Car', 'Electricty', 'Fitness']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      pl.payments[index].isChecked = val;
    });
  }
}
