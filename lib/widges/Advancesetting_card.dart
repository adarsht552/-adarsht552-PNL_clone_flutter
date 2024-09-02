import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/CurrencyProvider.dart';
import 'package:stock/Provider/ThemeProvider.dart';
import 'package:stock/widges/DropDownCurrency.dart';

class AdvanceSetting extends StatefulWidget {
  const AdvanceSetting({super.key});

  @override
  State<AdvanceSetting> createState() => _AdvanceSettingState();
}

class _AdvanceSettingState extends State<AdvanceSetting> {
  @override
  Widget build(BuildContext context) {
    final currentCurrencyCode = context.watch<Currency>().currency;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard(
            context,
            title: 'Theme',
            trailing: Switch(
              activeColor: Colors.blue,
              inactiveThumbColor: const Color.fromARGB(255, 11, 31, 47),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          SizedBox(height: 16.h),
          _buildSettingOption(
            title: "Change Your Currency ($currentCurrencyCode)",
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CurrencyBottomSheet(),
              );
            },
          ),
          _buildSettingOption(
            title: 'Contact us',
            onTap: () {
              // Handle contact us
            },
          ),
          _buildSettingOption(
            title: 'Privacy Policy',
            onTap: () {
              // Handle privacy policy
            },
          ),
          _buildSettingOption(
            title: 'Terms & Conditions',
            onTap: () {
              // Handle terms & conditions
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required Widget trailing, VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSettingOption(
      {required String title, required VoidCallback onTap}) { // removed incomplete parameter
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
