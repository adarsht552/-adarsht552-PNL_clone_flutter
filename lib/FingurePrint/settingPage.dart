import 'package:flutter/material.dart';
import 'package:stock/FingurePrint/Figer_auth.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FingerprintAuthService _authService = FingerprintAuthService();
  bool _isFingerprintEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadFingerprintStatus();
  }

  Future<void> _loadFingerprintStatus() async {
    bool isEnabled = await _authService.isFingerprintLockEnabled();
    setState(() {
      _isFingerprintEnabled = isEnabled;
    });
  }

  void _toggleFingerprint(bool value) async {
    if (value) {
      bool available = await _authService.isFingerprintAvailable();
      if (available) {
        bool authenticated = await _authService.authenticate();
        if (authenticated) {
          _authService.setFingerprintLock(true);
          setState(() {
            _isFingerprintEnabled = true;
          });
        }
      } else {
        // Show a message indicating that fingerprint is not available
      }
    } else {
      _authService.setFingerprintLock(false);
      setState(() {
        _isFingerprintEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      
      title: Text('Enable Fingerprint Lock'),
      value: _isFingerprintEnabled,
      onChanged: _toggleFingerprint,
    );
  }
}
