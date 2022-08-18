import 'package:flutter/cupertino.dart';

class PasswordState extends ChangeNotifier {
  String passphrase1 = "";
  String passphrase2 = "";
  int desiredLength = 1;
  String password = "";

  void UpdateFirstPassphrase(String newPassphrase) {
    passphrase1 = newPassphrase;
    notifyListeners();
  }

  void UpdateSecondPassphrase(String newPassphrase) {
    passphrase2 = newPassphrase;
    notifyListeners();
  }

  void UpdateDesiredLength(int newDesiredLength) {
    desiredLength = newDesiredLength;
    notifyListeners();
  }

  void UpdatePassword(String newPassphrase) {
    password = newPassphrase;
    notifyListeners();
  }
}