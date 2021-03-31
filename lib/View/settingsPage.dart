import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/Payment/Forms/CustomForms.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

import 'package:to_pay_app/View//Clippers/Clippers.dart';
import 'package:to_pay_app/models/bill.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage>
    with SingleTickerProviderStateMixin {
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
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: themeProvider.themeMode().blendBackgroundColor,
                largeTitle: Text(
                  "Home",
                  style: TextStyle(
                      color: themeProvider.themeMode().textColor,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800),
                ),
              ),
            ];
          },
          // backgroundColor: themeProvider.themeMode().blendBackgroundColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: themeProvider
                                .themeMode()
                                .blendBackgroundColor)),
                    width: scrWidth,
                    child: Row(
                      children: [
                        Text(
                          "Dark Mode",
                          style: TextStyle(fontFamily: 'avenir', fontSize: 16),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
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
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(top: 12, left: 15, right: 12, bottom: 10),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 0,
        focusColor: Colors.deepPurple,
        elevation: 16,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'avenir',
            color: themeProvider.themeMode().textColor),
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
