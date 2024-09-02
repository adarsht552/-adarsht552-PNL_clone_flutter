import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this package for date formatting



class CurrentDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date
    String formattedDate = DateFormat('d MMMM yyyy').format(now);

    return Text(
      formattedDate,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
