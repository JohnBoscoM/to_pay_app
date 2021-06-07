import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/View/Payment/Forms/CustomForms.dart';
import 'package:to_pay_app/controller/bankIdController.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/View/Payment/paymentList/paymentList.dart';
import 'package:to_pay_app/View/Clippers/Clippers.dart';
import 'package:to_pay_app/models/bill.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  int _value = 1;
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';
  final paymentBox = Hive.box('paymentBox');
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final deadlineController = TextEditingController();
  BankIdController bankIdController = new BankIdController();
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
          physics: NeverScrollableScrollPhysics(),
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
                        'Välkommen ',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 30,
                          color: themeProvider.themeMode().textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ), //
                    ),
                  ),

                  //
                  SizedBox(
                    height: scrHeight * 0.1,
                  ),
                  Container(
                    height: scrHeight * 0.4,
                    //  width: scrWidth * 0.6,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(120),
                      // color: Colors.orange.shade200,
                      image: DecorationImage(
                          image: AssetImage("assets/images/Login2.png"),
                          alignment: Alignment.center,
                          fit: BoxFit.scaleDown),
                    ),
                  ),
                  //
                  SizedBox(
                    height: scrHeight * 0.05,
                  ),
                  Text(
                    'Hjälten över din egna ekonomi',
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 21,
                      color: themeProvider.themeMode().textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: scrHeight * 0.01,
                  ),
                  Text(
                    'Din ekonomi säkert, smidigt och på en plats...',
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 15,
                      color: themeProvider.themeMode().textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(
                    height: scrHeight * 0.013,
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
                      bankIdController.launchBankIdApp();
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: scrWidth * 0.45,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(120),
                              // color: Colors.orange.shade200,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/bankid-logo-blue.png"),
                                  alignment: Alignment.center,
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Logga in',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scrHeight * 0.013,
                  ),
                  Text(
                    'Sekretess',
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 12,
                      color: themeProvider.themeMode().textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.blueAccent,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Colors.blueAccent[700],
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
