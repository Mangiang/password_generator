import 'package:flutter/cupertino.dart';

class PasswordState extends ChangeNotifier {
  String passphrase1 = "";
  String passphrase2 = "";
  int desiredLength = 1;
  String password = "";
  String blacklist = "";
  bool includeLowerCase = true;
  bool includeUpperCase = true;
  bool includeNumbers = true;
  bool includeSymbols = true;

  void updateFirstPassphrase(String newPassphrase) {
    passphrase1 = newPassphrase;
    notifyListeners();
  }

  void updateSecondPassphrase(String newPassphrase) {
    passphrase2 = newPassphrase;
    notifyListeners();
  }

  void updateDesiredLength(int newDesiredLength) {
    desiredLength = newDesiredLength;
    notifyListeners();
  }

  void updatePassword(String newPassphrase) {
    password = newPassphrase;
    notifyListeners();
  }

  void updateIncludeLowerCase(bool? newValue) {
    includeLowerCase = newValue ?? true;
    notifyListeners();
  }

  void updateIncludeUpperCase(bool? newValue) {
    includeUpperCase = newValue ?? true;
    notifyListeners();
  }

  void updateIncludeNumber(bool? newValue) {
    includeNumbers = newValue ?? true;
    notifyListeners();
  }

  void updateIncludeSymbols(bool? newValue) {
    includeSymbols = newValue ?? true;
    notifyListeners();
  }

  void updateblacklist(String newBlacklist) {
    blacklist = newBlacklist;
    notifyListeners();
  }
}