import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hive/hive.dart';
import 'package:to_pay_app/View/Payment/AddPaymentPage.dart';
import 'file:///C:/Users/John%20Bosco%20Matanda/Documents/App%20Development/to_pay_app/lib/View/payment/paymentsTabbedView.dart';
import 'package:to_pay_app/View/setThemePage.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/calendar/calendar_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/View/home.dart';
import 'package:to_pay_app/models/bill.dart';

class NavPage extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<NavPage> {
  final Box paymentBox = Hive.box('paymentBox');
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final deadlineController = TextEditingController();
  int _selectedIndex = 0;
  String dropdownValue = 'Other';
  Category category = new Category();
  void changeTab() {
    if (mounted) setState(() {});
  }

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  SnakeShape snakeShape = SnakeShape.indicator;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(0), topLeft: Radius.circular(0)),
  );
  EdgeInsets padding =
      const EdgeInsets.only(top: 0, bottom: 0, right: 2, left: 2);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<dynamic> _widgetOptions = [
    HomePage(),
    PaymentsTabbedPage(),
    AddPaymentPage(),
    CalendarPage(),
    SetThemePage(),
    //MyHomePage(),
  ];
  void createPayment(
      String title, double cost, DateTime deadline, String category) async {
    String title = titleController.text;
    double cost = double.parse(costController.text);
    var paymentItem = new BillItem(
        title, cost, _date, false, 'PaymentDateStatus', false, category, 3);
    paymentBox.add(paymentItem);
  }

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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        selectedLabelStyle: TextStyle(fontFamily: 'avenir'),
        backgroundColor: themeProvider.themeMode().navBarColor,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,

        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: themeProvider.themeMode().navBarForeground,
        selectedItemColor: snakeShape == SnakeShape.indicator
            ? themeProvider.themeMode().navBarForeground
            : null,
        unselectedItemColor: themeProvider.themeMode().unselectedItemColor,

        ///configuration for SnakeNavigationBar.gradient
        //snakeViewGradient: selectedGradient,
        //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        //unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.creditcard), label: 'Expenses'),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add_circled_solid,
                size: 45,
              ),
              label: 'Analytics'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
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
}
