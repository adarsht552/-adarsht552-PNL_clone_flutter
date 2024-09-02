import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hint;
  const CustomTextField({super.key, this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
