


import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/CustomWidgets/CustomCheckbox.dart';
import 'package:to_pay_app/View/CustomWidgets/CustomTabIndicator.dart';
import 'package:to_pay_app/View/Payment/paidPayements.dart';
import 'package:to_pay_app/View/Payment/unpaidPayments.dart';
import 'package:to_pay_app/View/Payment/allPayments.dart';
import 'package:to_pay_app/View/Payment/missedPayments.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/helpers/calendar.dart';
import 'package:to_pay_app/helpers/payments.dart';
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
  bool selected = false;
  bool unpaidSelected = false;
  bool paidSelected = false;
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.themeMode().blendBackgroundColor,
        body: SingleChildScrollView(
          physics: PageScrollPhysics(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Payments',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 30,
                          color: themeProvider.themeMode().textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ), //
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(left: 38, right: 68),
                    child: Column(

                      children: [
                        Row(
                          children: [
                           FilterChip(
                              backgroundColor: Colors.grey[700],
                              label: Text("Unpaid"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                              onSelected: (bool _selected){
                                setState(() {
                                  selected =  _selected;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FilterChip(
                              backgroundColor: Colors.grey[700],
                              selectedColor: Colors.blueAccent[700],
                              label: Text("Missed"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                              onSelected: (_selected){
                                setState(() {
                                  selected = _selected;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FilterChip(
                              backgroundColor: Colors.grey[700],
                              label: Text("Paid"),
                              labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                              onSelected: (_selected){
                                setState(() {
                                 selected =  _selected;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  Wrap(
                  children: [ buildPaidList(_height * 0.7, _width, themeProvider),
                    ]
                  ),
            ],
          ),
          ],
        ),
      ),
    ),
    );
  }



  Widget buildPaidList(double _height, double _width, ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        height: _height,
        width: _width,

        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), topLeft: Radius.circular(0)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if(paymentItem != null) {
              if (paymentItem.isChecked == false) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                      ),
                      child: Icon(
                          CupertinoIcons.delete_solid, size: 32, color: Colors.black38),
                    ),
                  ),
                  key: Key(paymentItem.toString()),
                  onDismissed: (direction) {
                    paymentBox.delete(index);
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: Text(paymentItem.title + " has been removed"),
                    ));
                  },
                  child: new Container(
                    padding: new EdgeInsets.all(15),
                    //elevation: 0,
                      decoration:   BoxDecoration(
                        //color: themeProvider.themeMode().color,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: themeProvider.themeMode().borderColor),
                        // boxShadow: themeProvider.themeMode().itemShadow
                      ),
                    margin: new EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        new ListTile(
                          onLongPress: () {},
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
                              themeProvider
                                  .categoryIcon(paymentItem.category)
                                  .icon,
                              size: 30,
                            ),
                          ),

                          // Checkbox(
                          //     value: paymentItem.isChecked,
                          //     onChanged: (bool value) {
                          //       setState(() {
                          //         paymentItem.isChecked = value;
                          //       });
                          //     }),
                          isThreeLine: false,
                          dense: true,
                          //font change
                          contentPadding: EdgeInsets.all(1),
                          title: Text(paymentItem.title, style: TextStyle(fontFamily:'avenir', fontSize: 17, fontWeight: FontWeight.w700)),
                          subtitle: Container(
                  child: Text(paymentItem.deadline.day.toString() + ' ' +monthName(paymentItem.deadline.month), style: TextStyle(fontFamily:'avenir', fontSize: 13, fontWeight: FontWeight.w700)),
            ),

                          trailing: Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.350,
                              child: Wrap(
                                  children: [
                                Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  SizedBox(width: 50,),
                                  Text( paymentItem.cost.truncate().toString() + ' SEK ', style: TextStyle(fontFamily:'avenir', fontSize: 20, fontWeight: FontWeight.w700),),
                                  SizedBox(width: 10,),
                                  CustomCheckbox(paymentItem.isChecked,23.0,18.0,Colors.blue,Colors.white),
                                  SizedBox(width: 20,)
                                ],
                              ),
                              ),
                                )
                              ],
                              )
                              )
                            ),
                          // onChanged: (bool val) {
                          //   itemChange(val, index);
                          // }
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return Container(
              //     child: Center(
              //   child: Text(
              //     "You have no paid bills, Either you got no bills\n or you gotta get to work!",
              //     style: TextStyle(
              //         fontFamily: "avenir",
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold),
              //   ),
              // )
            );
          },
        ),
      ),
    );
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

