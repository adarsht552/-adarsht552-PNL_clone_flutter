import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock/FingurePrint/Figer_auth.dart';
import 'package:stock/FingurePrint/LockScreen.dart';
import 'package:stock/Provider/ThemeProvider.dart';
import 'package:stock/Provider/CurrencyProvider.dart'; // Import your Currency provider
import 'package:stock/Provider/lossProvider.dart';
import 'package:stock/Provider/profitProvider.dart';
import 'package:stock/Screens/Bottom_navigation/bottom_navigation.dart';
import 'package:stock/widges/Themes/Dark_and_light_Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize ThemeProvider
  final themeProvider = ThemeProvider();
  await themeProvider.init();
  
  // Initialize CurrencyProvider
  final currencyProvider = Currency();
  await currencyProvider.init();
  
  // Initialize ProfitProvider and load data
  final profitProvider = ProfitProvider();
  await profitProvider.loadData();

  final lossProvider = LossProvider();
  await lossProvider.loadData();

  runApp(
    MultiProvider(
      providers: [
        // Use the same instances initialized above
        ChangeNotifierProvider<ThemeProvider>.value(
          value: themeProvider,
        ),
        ChangeNotifierProvider<Currency>.value(
          value: currencyProvider,
        ),
        ChangeNotifierProvider<ProfitProvider>.value(
          value: profitProvider,  // Use the already initialized provider here
        ),
        ChangeNotifierProvider<LossProvider>.value(
          value: lossProvider,  // Use the already initialized provider here
        ),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FingerprintAuthService _authService = FingerprintAuthService();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Stock App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: FutureBuilder<bool>(
              future: _authService.isFingerprintLockEnabled(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    return LockScreen();
                  } else {
                    return BottomNavigation(); // Replace with your home screen
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            routes: {
              '/home': (context) => const BottomNavigation(), // Ensure this matches the route you want
              // Define other routes here if necessary
            },
          );
        },
      ),
    );
  }
}
