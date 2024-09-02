import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/ThemeProvider.dart';
import 'package:stock/widges/Current_date.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?const Color(0xff141414):Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            CurrentDateWidget(),
            
          ],
        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}