import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfitProvider with ChangeNotifier {
  double _profit = 0.0;
  String _selectedDate = DateFormat('MM-dd').format(DateTime.now());

  double get profit => _profit;
  String get selectedDate => _selectedDate;

  // Set profit and save it to local storage
  void setProfit(double value) async {
    _profit = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('profit', _profit); // Save profit locally
  }

  // Set selected date and save it to local storage
  void setSelectedDate(String date) async {
    _selectedDate = date;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDate', _selectedDate); // Save date locally
  }

  // Load saved profit and date from local storage
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profit = prefs.getDouble('profit') ?? 0.0;
    _selectedDate = prefs.getString('selectedDate') ?? DateFormat('MM-dd').format(DateTime.now());
    notifyListeners();
  }

  // Save total to SharedPreferences
  Future<void> saveTotal(double total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('total', total); // Save the total locally
  }

  // Load total from SharedPreferences
  Future<double> loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('total') ?? 0.0; // Return 0.0 if not found
  }
}
