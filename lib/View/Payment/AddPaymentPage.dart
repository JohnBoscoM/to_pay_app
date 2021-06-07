import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/Payment/Forms/CustomForms.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/View/Payment/paymentList/paymentList.dart';
import 'package:to_pay_app/View/Clippers/Clippers.dart';
import 'package:to_pay_app/models/bill.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage>
    with SingleTickerProviderStateMixin {
  int _value = 1;
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';
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

  void createPayment(String title, double cost, DateTime deadline,
      String category, int recurrenceValue) async {
    // String title = titleController.text;
    // double cost = double.parse(costController.text);
    var paymentItem = new BillItem(title, cost, _date, false,
        'PaymentDateStatus', false, category, recurrenceValue);
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
                          color: Colors.brown,
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
                          padding:
                              EdgeInsets.only(left: 12, top: 10, bottom: 10),
                          width: scrWidth,
                          child: Text(
                            'Recurrence (optional) ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 15,
                              color: Colors.brown,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Wrap(
                              children: List<Widget>.generate(
                                3,
                                (int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ChoiceChip(
                                      backgroundColor: Colors.black38,
                                      selectedColor: Colors.brown[800],
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 15),
                                      label:
                                          Text(getRecurrenceIndexLabel(index)),
                                      selected: _value == index,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _value = selected ? index : null;
                                          // paymentViewList = getPaymentList(index);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
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
                        '* Category',
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 15,
                          color: Colors.brown[600],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, bottom: 8),
                      child: buildDropDownList(scrWidth, themeProvider),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                          child: Text(
                            '* Title',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 15,
                              color: Colors.brown[600],
                            ),
                          ),
                        ),
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: TextFormField(
                          cursorColor: themeProvider.themeMode().textColor,
                          // obscureText: 'Title' == '' ? true : false,
                          // this can be changed based on usage -
                          // such as - onChanged or onFieldSubmitted
                          onChanged: (value) {
                            setState(() {
                              titleController.text = value;
                              isSubmitted = true;
                            });
                          },
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 19,
                              color: themeProvider.themeMode().textColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: themeProvider.themeMode().textColor,
                                fontWeight: FontWeight.w600),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 27, horizontal: 25),
                            focusColor: Colors.brown,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeProvider.themeMode().borderColor,
                              ),
                            ),
                            suffixIcon: isSubmitted == true
                                // will turn the visibility of the 'checkbox' icon
                                // ON or OFF based on the condition we set before
                                ? Visibility(
                                    visible: true,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container()),
                                  )
                                : Visibility(
                                    visible: false, child: Container()),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  SizedBox(
                    height: 20,
                  ),
                  //
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                          child: Text(
                            '* Cost',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 15,
                              color: Colors.brown[600],
                            ),
                          ),
                        ),
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: themeProvider.themeMode().textColor,
                          // obscureText: 'Title' == '' ? true : false,
                          // this can be changed based on usage -
                          // such as - onChanged or onFieldSubmitted
                          onChanged: (value) {
                            setState(() {
                              costController.text = value;
                              isSubmitted = true;
                            });
                          },
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Cost",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: themeProvider.themeMode().textColor,
                                fontWeight: FontWeight.w600),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 27, horizontal: 25),
                            focusColor: Colors.brown,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeProvider.themeMode().borderColor,
                              ),
                            ),
                            suffixIcon: isSubmitted == true
                                // will turn the visibility of the 'checkbox' icon
                                // ON or OFF based on the condition we set before
                                ? Visibility(
                                    visible: true,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container()),
                                  )
                                : Visibility(
                                    visible: false, child: Container()),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
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
                        '* Due Date',
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 15,
                          color: Colors.brown[600],
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
                          color: Colors.brown[700],
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: _date.toString().substring(0, 10),
                        hintStyle: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 18,
                            color: themeProvider.themeMode().textColor,
                            fontWeight: FontWeight.w600),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 27, horizontal: 25),
                        focusColor: Colors.brown[700],
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.brown[700]),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: themeProvider.themeMode().borderColor,
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
                      color: Colors.brown[300],
                    ),
                    //
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.transparent;
                        return null;
                      }),
                    ),
                    onPressed: () {
                      createPayment(
                          titleController.text,
                          double.parse(costController.text),
                          _date,
                          _categoryValue,
                          _value);
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: scrWidth * 0.75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.brown[800],
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
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.brown,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Colors.brown[800],
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              SizedBox(
                height: 20,
              )
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
        border: Border.all(color: themeProvider.themeMode().borderColor),
      ),
      padding: EdgeInsets.only(top: 12, left: 15, right: 12, bottom: 10),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 0,
        focusColor: Colors.blueAccent[700],
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
