import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifierSnabbsaldo extends ChangeNotifier {
  bool _blured = false;

  get getBlured => _blured;

  buttonPressed() {
    if (_blured == true) {
      _blured = false;
    } else {
      _blured = true;
    }
    notifyListeners();
  }
}
