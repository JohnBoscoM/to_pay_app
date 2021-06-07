import 'package:to_pay_app/services/BankID/bankIdApi.dart';

class BankIdController {
  BankIdService bankIdService = new BankIdService();

  void launchBankIdApp() {
    bankIdService.openBankId();
  }
}
