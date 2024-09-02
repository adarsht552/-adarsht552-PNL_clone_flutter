import 'package:flutter/material.dart';
import 'package:stock/FingurePrint/Figer_auth.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final FingerprintAuthService _authService = FingerprintAuthService();

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

void _authenticate() async {
  bool authenticated = await _authService.authenticate();
  if (authenticated) {
    Navigator.pushReplacementNamed(context, '/home'); // Make sure this route is defined in the MaterialApp
  } else {
    // Handle authentication failure
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
