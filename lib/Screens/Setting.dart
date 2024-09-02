import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock/widges/Advancesetting_card.dart';
import 'package:stock/widges/CustomProfile.dart';
import 'package:stock/widges/setting_card.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleThemeMode(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        elevation: 0,
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomProfile(),
          SettingCard(),
          Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Text(
              'Advance Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ),
          AdvanceSetting()
       
        ],
      ),
    );
  }
}
