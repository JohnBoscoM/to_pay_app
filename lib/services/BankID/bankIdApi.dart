import 'dart:async';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class BankIdService {
  String apiUrl = 'https://api.banksignering.se/api/auth';
  String autoStartToken = 'bdaccd84-6a98-4276-ba70-35e944b704af';
  String redirect = "rememberapp://";
  String _url =
      "https://app.bankid.com/?autostarttoken=[bdaccd84-6a98-4276-ba70-35e944b704af]&redirect=rememberapp://";

  Future<void> openBankId() async {
    var url =
        "https://app.bankid.com/?autostarttoken=[bdaccd84-6a98-4276-ba70-35e944b704af]&redirect=rememberapp://";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}