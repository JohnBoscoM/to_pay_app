
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

import 'ButtonWidget.dart';
import 'InputField.dart';

class InputWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            decoration: BoxDecoration(
              color: themeProvider.themeMode().blendBackgroundColor,
              borderRadius: BorderRadius.circular(0)
            ),
            child: InputField(),
          ),
          SizedBox(height: 40,),
          SizedBox(height: 40,),
          //Button()
        ],
      ),
    );
  }
}