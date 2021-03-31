import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';

import 'calendar.dart';

class PaymentSearch extends SearchDelegate<String> {
  final paymentBox = Hive.box('paymentBox');

  List<dynamic> getPaymentTitles(){
    var titles = <String>[];
  paymentBox.values.toList().forEach((paymentItem) {
    titles.add(paymentItem.title);
  });
  return titles;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final suggestionList = getPaymentTitles();
    return ListView.builder(
       itemBuilder: (context, index) => ListTile(
         trailing: Icon(CupertinoIcons.arrow_right),
         title: Text(suggestionList[index]),
       ),
    );

  }
}