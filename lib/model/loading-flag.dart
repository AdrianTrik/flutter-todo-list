import 'package:flutter/cupertino.dart';

class LoadingFlag with ChangeNotifier {
  bool isSaving = false;

  void toggleSaving() {
    this.isSaving = !this.isSaving;
    notifyListeners();
  }
}
