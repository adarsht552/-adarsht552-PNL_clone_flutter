import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/CurrencyProvider.dart';
import 'package:stock/Provider/ThemeProvider.dart';
import 'package:stock/widges/Current_date.dart';
import 'package:stock/widges/common/app_bar.dart';
import 'package:stock/widges/homeFlotingBotton_.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ThemeProvider theme = ThemeProvider();
  @override
  Widget build(BuildContext context) {
  final theme = Provider.of<ThemeProvider>(context).themeMode;
    final currentCurrencyCode = context.watch<Currency>().currency;

    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => HomeFlotingBotton(),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.yellow,
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      body: Center(
          child: Text(

        'Home 10000 SCreen $currentCurrencyCode, ',
        style: TextStyle(fontSize: 30.sp, color: theme == ThemeMode.dark?Colors.white:Colors.black),
      )),
    );
  }
}
