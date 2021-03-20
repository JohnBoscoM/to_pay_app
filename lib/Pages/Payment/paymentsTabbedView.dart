


import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/CustomWidgets/CustomTabIndicator.dart';
import 'package:to_pay_app/Pages/Payment/paidPayements.dart';
import 'package:to_pay_app/Pages/Payment/unpaidPayments.dart';
import 'package:to_pay_app/Pages/Payment/allPayments.dart';
import 'package:to_pay_app/Pages/Payment/missedPayments.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';


class PaymentsTabbedPage extends StatefulWidget {
  @override
  _PaymentsTabbedPageState createState() => _PaymentsTabbedPageState();
}

class _PaymentsTabbedPageState extends State<PaymentsTabbedPage>
    with SingleTickerProviderStateMixin {
  final Box paymentBox = Hive.box('paymentBox');
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final deadlineController = TextEditingController();
  int _sliding = 1;
  AllPaymentsList pl = new AllPaymentsList();
  Category category = new Category();
  bool checkBoxValue = false;

  DateTime _date = DateTime.now();
  String _categoryValue;
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
  String dropdownValue = 'Other';

   var  paymentStatusPages = [
     UnPaidPaymentsPage(),
     PaidBillsPage(),
     MissedBillsPage()
   ];

  void createPayment(
      String title, double cost, DateTime deadline, String category) async {

    String title = titleController.text;
    double cost = double.parse(costController.text);
    var paymentItem = new BillItem(
        title, cost, _date, false, 'PaymentDateStatus', false, category);
    paymentBox.add(paymentItem);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: paymentStatusPages.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  // Future _openBox() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   paymentBox = await Hive.openBox('paymentBox');
  //   return;
  // }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    costController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    var mediaQuery = MediaQuery.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.themeMode().blendBackgroundColor,
          elevation: 0,

          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 45.0),
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: CupertinoSlidingSegmentedControl(
                        children: {
                          //0: Text('All', style: TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w600),),
                          0: Text('UnPaid', style: TextStyle( fontFamily: 'avenir', fontWeight: FontWeight.w600),),
                          1: Text('Paid', style: TextStyle( fontFamily: 'avenir', fontWeight: FontWeight.w600),),
                          2: Text('Missed', style: TextStyle( fontFamily: 'avenir', fontWeight: FontWeight.w600),),
                        },
                        groupValue: _sliding,
                        onValueChanged: (newValue) {
                          setState(() {
                            _sliding = newValue;
                          });
                        }
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          //TabBar(
          //   unselectedLabelColor: themeProvider.themeMode().textColor,
          //   labelColor: Colors.white,
          //   physics: BouncingScrollPhysics(),
          //   indicatorPadding: EdgeInsets.all(0),
          //   //indicatorSize: TabBarIndicatorSize.label,
          //   indicator: CustomTabIndicator(),
          //   //indicatorColor: Colors.grey[800],
          //   onTap: (index) {
          //     // Should not used it as it only called when tab options are clicked,
          //     // not when user swapped
          //   },
          //   controller: _controller,
          //   tabs: list,
          // ),
          title: Center(child: Padding(padding: EdgeInsets.only(top: 20), child: Text('Payments', style: TextStyle(fontSize: 26, fontFamily: 'avenir', fontWeight: FontWeight.w700),))),
        ),
        body:
          paymentStatusPages[_sliding],

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _buildModal(themeProvider, mediaQuery, height);
          },
        ),
      ),
    );
  }



  Widget _buildModal(
      ThemeProvider themeProvider, MediaQueryData mediaQuery, double height) {
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
            controller: titleController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.title_outlined),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
            controller: costController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.payment_outlined),
                labelText: "Cost",
                hoverColor: Colors.red,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
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
            controller: deadlineController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText: "Deadline",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
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
            createPayment(titleController.text,
                double.parse(costController.text), _date, _categoryValue);
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

        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items:
        category.categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            onTap: () {
              _categoryValue = value;
            },
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

