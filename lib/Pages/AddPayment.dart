import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/nav.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/user.dart';


class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final paymentBox = Hive.box('paymentBox');
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final deadlineController = TextEditingController();

  void createPayment(
      String title, double cost, DateTime deadline, String category) async {
    String title = titleController.text;
    double cost = double.parse(costController.text);
    var paymentItem = new BillItem(
        title, cost, _date, false, 'PaymentDateStatus', false, category);
    paymentBox.add(paymentItem);
  }
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
    titleController.dispose();
    costController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeProvider.themeMode().blendBackgroundColor,
          elevation: 0 ,

          title: Center(widthFactor: width, child: Padding(padding: EdgeInsets.only(top: 30, bottom: 25), child:Text("Register Payment",style: TextStyle(fontSize: 20, fontFamily: "avenir", fontWeight: FontWeight.w700),)))
      ),
     body: SafeArea(

    child: Container(
    decoration: BoxDecoration(
      color: themeProvider.themeMode().blendBackgroundColor,
      // image: DecorationImage(
      //   repeat: ImageRepeat.repeatY,
      //     image: AssetImage("assets/images/add-payment.png"),
      //     alignment: Alignment.topCenter,
      //     fit: BoxFit.scaleDown
      // ),
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: width,
        alignment: Alignment.center,
        child:  Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child:ActionChip(
                  label: Text('2nd Month', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "avenir")),
                  onPressed: () {
                    print("If you stand for nothing, Burr, what’ll you fall for?");
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:ActionChip(
                  label: Text('Monthly', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "avenir")),
                  onPressed: () {
                    print("If you stand for nothing, Burr, what’ll you fall for?");
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:ActionChip(
                  label: Text('Once', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "avenir")),
                  onPressed: () {
                    print("If you stand for nothing, Burr, what’ll you fall for?");
                  }
              ),
            )
          ],

        ),
        ),
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(

          ),
          child: Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400],),
              color: themeProvider.themeMode().formColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            hintText: 'Title',
                            hintStyle:
                            TextStyle(color: Colors.black, fontSize: 20, fontFamily: "avenir"),
                            icon: Icon(CupertinoIcons.bookmark_fill,
                                color: Colors.deepPurple[800])),
                      ),
                    )),
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400],),
            color: themeProvider.themeMode().formColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Cost',
                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20, fontFamily: "avenir"),
                          icon: Icon(CupertinoIcons.creditcard_fill,
                              color: Colors.deepPurple[800],size: 30,)),
                    ),
                  )),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400],),
            color: themeProvider.themeMode().formColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      autofocus: false,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _selectDate(context);
                          });
                        },
                      decoration: InputDecoration(


                          border: InputBorder.none,
                          hintText: 'Deadline',
                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20, fontFamily: "avenir"),
                          icon: Icon(CupertinoIcons.calendar,
                            color: Colors.deepPurple[800],size: 30,)),
                    ),
                  )),
            ],
          ),
        ),
        buildDropDownList(themeProvider),

        Container(
          decoration: BoxDecoration(

          ),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 70, right: 50, left: 50),
          color: Colors.transparent,
          elevation: 0,
          onPressed: () {
            createPayment(titleController.text,
                double.parse(costController.text), _date, _categoryValue);
            //
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => NavPage()),
            // );
          },
          textColor: Colors.white,
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 70),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "avenir"),
              ),
            ),
          ),
        ),
        ),

      ],
    ),
    ),
     ),
    );
  }
  Widget buildDropDownList(ThemeProvider themeProvider) {
    return Container(
      margin: EdgeInsets.only(right: 200, left: 10, bottom: 20, top: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400],),
        color: themeProvider.themeMode().formColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, left: 20, right: 30, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
        margin: EdgeInsets.only(right: 10, left: 0, bottom: 0, top: 6),
        child: Icon(CupertinoIcons.arrow_down_circle_fill, size: 30, color: Colors.deepPurple[800], )
        ),
      DropdownButton<String>(
        value: dropdownValue,

        iconSize: 0,
        elevation: 0,
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
            child: Text(value, style: TextStyle(color: themeProvider.themeMode().textColor, fontFamily: "avenir", fontSize: 20),),
            onTap: () {
              _categoryValue = value;
            },
          );
        }).toList(),
      ),
      ],
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
