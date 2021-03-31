import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/helpers/search.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final paymentBox = Hive.box('paymentBox');

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.search),
              onPressed: () {
                showSearch(context: context, delegate: PaymentSearch());
              }
          ),
        ],
      ),
    );
  }
}