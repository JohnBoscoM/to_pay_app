import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/Pages/widgets/Header.dart';
import 'package:to_pay_app/Pages/widgets/InputWrapper.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/paymentItem.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:to_pay_app/budget/payments/paymentList.dart';
import 'package:to_pay_app/models/paymentItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_pay_app/models/user.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Box _userBox;

  @override
  // void initState() {
  //   super.initState();
  //   Hive.registerAdapter(UserAdapter());
  //   _openBox();
  // }

  Future _openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _userBox = await Hive.openBox('userBox');
    return;
  }

  bool checkBoxValue = false;
  // final userBox = await Hive.openBox('user');
  //final paymentItemBox = await Hive.openBox('user');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: themeProvider.themeMode().gradient,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Header(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: themeProvider.themeMode().color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: InputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}
