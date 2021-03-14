import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';


class CustomForms extends StatefulWidget {
  String label;
  String inputHint;
  final controller;
  bool isDateForm;

  CustomForms({this.label, this.inputHint, this.controller, this.isDateForm});
  @override
  _CustomFormsState createState() => _CustomFormsState();
}

class _CustomFormsState extends State<CustomForms> {
  final paymentBox = Hive.box('paymentBox');

  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            obscureText: widget.label == '' ? true : false,
            // this can be changed based on usage -
            // such as - onChanged or onFieldSubmitted
            onChanged: (value) {
              setState(() {
                isSubmitted = true;
              });
            },
            style: TextStyle(
                fontSize: 19,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: widget.inputHint,
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
              suffixIcon: isSubmitted == true
              // will turn the visibility of the 'checkbox' icon
              // ON or OFF based on the condition we set before
                  ? Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container()
                ),
              )
                  : Visibility(
                visible: false,
                child: Container()
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
