import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/nav.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/user.dart';

import '../home.dart';

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final paymentBox = Hive.box('paymentBox');
  final usernameController = TextEditingController();
  final incomeController = TextEditingController();
  Category category = new Category();
  DateTime _date = DateTime.now();
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: <Widget>[
      Text("New Payment",style: TextStyle(fontSize: 30, fontFamily: "avenir", fontWeight: FontWeight.w700)),
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/add-payment.png"),
                alignment: Alignment.center,
                scale: 1),
              ),
           child:Container(
             margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   flex: 1,
                   child: Padding(
                     padding: EdgeInsets.only(left: 20),
                     child: TextFormField(
                       decoration: InputDecoration(
                           focusColor: themeProvider.themeMode().appColor,
                           labelText: "Title",
                           labelStyle: TextStyle(
                               fontSize: 20, color: themeProvider.themeMode().textColor, fontFamily: 'avenir'
                           ),
                           border: OutlineInputBorder(),
                           hintText: 'Enter Title',
                           hintStyle: TextStyle(color: Colors.grey[200],fontFamily: 'avenir'),
                           suffixIcon: Icon(CupertinoIcons.bookmark,
                               color: themeProvider.themeMode().textColor)),
                     ),
                   ),
                 ),
               ],
             ),
           ),
          // TextField(
          //   controller: usernameController,
          //   decoration: InputDecoration(
          //       hintText: "Title",
          //       hintStyle: TextStyle(color: Colors.grey),
          //       border: InputBorder.none),
          // ),
        ),
        // Container(
        //   padding: EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //       border: Border(bottom: BorderSide(color: Colors.grey[200]))),
        //   child: TextField(
        //     controller: incomeController,
        //     decoration: InputDecoration(
        //         hintText: "Cost",
        //         hintStyle: TextStyle(color: Colors.grey),
        //         border: InputBorder.none),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: themeProvider.themeMode().appColor,
                        labelText: "Cost",
                          labelStyle: TextStyle(
                            fontSize: 20, color: themeProvider.themeMode().textColor, fontFamily: 'avenir'
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Cost',
                          hintStyle: TextStyle(color: themeProvider.themeMode().textColor,fontFamily: 'avenir'),
                          suffixIcon: Icon(CupertinoIcons.creditcard,
                              color: themeProvider.themeMode().textColor)),
                    ),
                  ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusColor: themeProvider.themeMode().appColor,
                        labelText: "Deadline",
                        labelStyle: TextStyle(
                            fontSize: 20, color: themeProvider.themeMode().textColor, fontFamily: 'avenir'
                        ),
                        border: OutlineInputBorder(),
                        enabled: false,
                        hintStyle: TextStyle(color: themeProvider.themeMode().textColor,fontFamily: 'avenir'),
                        suffixIcon: Icon(CupertinoIcons.calendar,
                            color: themeProvider.themeMode().textColor)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        focusColor: themeProvider.themeMode().appColor,
                        labelText: "Deadline",
                        labelStyle: TextStyle(
                            fontSize: 20, color: themeProvider.themeMode().textColor, fontFamily: 'avenir'
                        ),
                        border: OutlineInputBorder(),
                        enabled: false,
                        hintStyle: TextStyle(color: themeProvider.themeMode().textColor,fontFamily: 'avenir'),
                        suffixIcon: Icon(CupertinoIcons.calendar,
                            color: themeProvider.themeMode().textColor)),
                  ),
                ),
              ),
            ],
          ),
        ),

        RaisedButton(
          padding: EdgeInsets.only(top: 70, right: 50, left: 50),
          color: Colors.transparent,
          elevation: 0,
          onPressed: () {
            // createUser(
            //     usernameController.text, double.parse(incomeController.text));

            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NavPage()),
  );
          },
          textColor: Colors.white,
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.circular(30),
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


  Widget buildSearchBar(ThemeProvider themeProvider) {
    return PreferredSize(
      preferredSize: Size(0,150),
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
            decoration: BoxDecoration(
              color: themeProvider.themeMode().searchBarColor,
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle:
                            TextStyle(color: themeProvider.themeMode().textColor),
                            icon: Icon(CupertinoIcons.search,
                                color: themeProvider.themeMode().textColor)),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );

    Container(
      margin: EdgeInsets.only(right: 0, left: 0, bottom: 40, top: 40),
      decoration: BoxDecoration(
        color: themeProvider.themeMode().searchBarColor,
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle:
                      TextStyle(color: themeProvider.themeMode().textColor),
                      icon: Icon(CupertinoIcons.search,
                          color: themeProvider.themeMode().textColor)),
                ),
              )),
        ],
      ),
    );
  }
}
