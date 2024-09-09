import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LossProvider with ChangeNotifier {
  double _loss = 0.0;
  String _selectedDate = DateFormat('MM-dd').format(DateTime.now());  // Correct date format

  double get loss => _loss;
  String get selectedDate => _selectedDate;

  Future<void> setLoss(double value) async {
    _loss = value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble('loss', _loss);  // Store in SharedPreferences
    notifyListeners();
  }

  Future<void> setDate(String date) async {
    _selectedDate = date;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('date', _selectedDate);  // Store in SharedPreferences
    notifyListeners();
  }

  Future<void> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _loss = pref.getDouble('loss') ?? 0.0;
    _selectedDate = pref.getString('date') ?? DateFormat('MM-dd').format(DateTime.now());  // Correct date format
    notifyListeners();  // Notify listeners after loading data
  }
    Future<void> saveTotal(double total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('total', total); // Save the total locally
  }
    Future<double> loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('total') ?? 0.0; // Return 0.0 if not found
  }
}
