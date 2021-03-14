import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/Payment/Forms/CustomForms.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

import 'package:to_pay_app/Pages/Clippers/Clippers.dart';
import 'package:to_pay_app/models/bill.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}
class _AddPaymentPageState extends State<AddPaymentPage> with SingleTickerProviderStateMixin {
  final paymentBox = Hive.box('paymentBox');
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final deadlineController = TextEditingController();
  DateTime _date = DateTime.now();
  Category category = new Category();
  String _categoryValue;
  String dropdownValue = 'Household';
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
  void createPayment(
      String title, double cost, DateTime deadline, String category) async {
    String title = titleController.text;
    double cost = double.parse(costController.text);
    var paymentItem = new BillItem(
        title, cost, _date, false, 'PaymentDateStatus', false, category);
    paymentBox.add(paymentItem);
  }
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                        'Register Payment',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 30,
                          color: themeProvider.themeMode().textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ), //
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'Create new payment',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(left: 38, right: 68),
                    child: Column(

                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: scrWidth,
                        child: Text(
                          'Recurrence: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                      children: [
                        Chip(
                          backgroundColor: Colors.deepPurple,
                          label: Text("3rd Month"),
                          labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Chip(
                          backgroundColor: Colors.deepPurple,
                          label: Text("Monthly"),
                          labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Chip(
                          backgroundColor: Colors.deepPurple,
                          label: Text("Weekly"),
                          labelStyle: TextStyle(color: Colors.white, fontFamily: "avenir", fontSize: 15, fontWeight: FontWeight.w700),
                        ),

                      ],
                    ),
                    ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(padding: const EdgeInsets.only(left: 40.0, bottom: 8),
                    child: buildDropDownList(scrWidth, themeProvider),
                    ),
                  ),


                  SizedBox(
                    height: 20,
                  ),
                  //
                  CustomForms(
                    label: 'Title',
                    inputHint: 'Rent',
                    controller: titleController,
                  ),
                  //
                  SizedBox(
                    height: 20,
                  ),
                  //
                  CustomForms(
                    label: 'Cost',
                    inputHint: '4500',
                    controller: costController,
                  ),
                  //
                  SizedBox(
                    height: 30,
                  ),
                  //
                  // CustomForms(
                  //   label: 'Due Date',
                  //   inputHint: new DateTime.now().toString().substring(0,10),
                  //   controller: deadlineController,
                  //   isDateForm: true,
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                      child: Text(
                        'Due Date',
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                    child: TextFormField(
                      readOnly: true,
                      // this can be changed based on usage -
                      // such as - onChanged or onFieldSubmitted
                      onTap: () {
                        setState(() {
                        _selectDate(context);
                        });
                      },
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: _date.toString().substring(0, 10),
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: themeProvider.themeMode().textColor,
                            fontWeight: FontWeight.w600),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 27, horizontal: 25),
                        focusColor: Colors.deepPurple,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Payment will be registered as a one time payment if\nno recurrence option is chosen",
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[400],
                    ),
                    //
                  ),
                  RaisedButton(
                    color: themeProvider.themeMode().blendBackgroundColor,
                    elevation: 0,
                    focusElevation: 0,
                    highlightElevation: 3,
                    hoverElevation: 0,
                      disabledElevation: 0,
                    onPressed: (){

                     // createPayment();
                    },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: scrWidth * 0.85,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Create Payment',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Already have an account? ',
                  //         style: TextStyle(
                  //           fontFamily: 'Product Sans',
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xff8f9db5).withOpacity(0.45),
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: 'Sign In',
                  //         style: TextStyle(
                  //           fontFamily: 'Product Sans',
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xff90b7ff),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.deepPurple,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Colors.deepPurple[800],
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDownList(_width, ThemeProvider themeProvider) {
    return Container(
      width: _width * 0.825,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border:  Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(top: 12, left: 15, right: 12, bottom: 10),
      child: DropdownButton<String>(

        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 0,
        focusColor: Colors.deepPurple,
        elevation: 16,
        style: TextStyle(fontSize: 18, fontFamily: 'avenir', color: themeProvider.themeMode().textColor),
        underline: Container(
          height: 5,
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
}

class Neu_button extends StatelessWidget {
  Neu_button({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xff0962FF),
          ),
        ),
      ),
    );
  }
}



