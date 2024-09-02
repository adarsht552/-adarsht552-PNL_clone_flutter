import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currency with ChangeNotifier {
  String _currency = 'USD';
  String get currency => _currency;

  Future<void> init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _currency = pref.getString('currency') ?? 'USD';
    notifyListeners();
  }

  void changeCurrency(String newCurrency) async {
    _currency = newCurrency;
    // Save the new currency to SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('currency', newCurrency);
    notifyListeners();
  }
}
