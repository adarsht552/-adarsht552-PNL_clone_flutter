import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
import 'package:stock/FingurePrint/Figer_auth.dart';

class SettingCard extends StatefulWidget {
  const SettingCard({super.key});

  @override
  _SettingCardState createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fingerprint not available on this device')),
        );
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
    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: Column(
          children: [
            _buildSettingItem(
              title: 'Backup & Restore',
              icon: RiveIcon.reload,
              onTap: () => print('Backup & Restore tapped'),
            ),
            const Divider(),
            _buildSettingItem(
              title: 'Export to Excel',
              icon: RiveIcon.edit,
              onTap: () => print('Export to Excel tapped'),
            ),
            const Divider(),
            _buildSettingItem(
              title: 'Export PDF',
              icon: RiveIcon.copy,
              onTap: () => print('Export PDF tapped'),
            ),
            const Divider(),
            _buildSettingItemWithSwitch(
              title: 'Passcode',
              icon: RiveIcon.settings3,
              value: _isFingerprintEnabled,
              onChanged: _toggleFingerprint,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required RiveIcon icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: RiveAnimatedIcon(
          riveIcon: icon,
          width: 40.w,
          height: 40.h,
          strokeWidth: 2.5,
          color: Colors.blue,
          loopAnimation: false,
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 24.w,
        ),
      ),
    );
  }

  Widget _buildSettingItemWithSwitch({
    required String title,
    required RiveIcon icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: RiveAnimatedIcon(
        riveIcon: icon,
        width: 40.w,
        height: 40.h,
        strokeWidth: 2.5,
        color: Colors.blue,
        loopAnimation: false,
      ),
      trailing: Switch(
        activeColor: Colors.blue,
      inactiveThumbColor: Colors.blueGrey,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
