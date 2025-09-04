import 'package:flutter/material.dart';

class CreatureProvider with ChangeNotifier {
  int _growth = 0;

  int get growth => _growth;

  void grow() {
    _growth++;
    notifyListeners();
  }

  void penalize() {
    if (_growth > 0) {
      _growth--;
      notifyListeners();
    }
  }
}
