import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/CurrencyProvider.dart';
import 'package:stock/Provider/ThemeProvider.dart';
import 'package:stock/Provider/lossProvider.dart';
import 'package:stock/Provider/profitProvider.dart';

class ProfitLosscard extends StatelessWidget {
  const ProfitLosscard({super.key});

  // Calculate total (profit - loss)
  double calculateTotal(
      ProfitProvider profitProvider, LossProvider lossProvider) {
    return profitProvider.profit - lossProvider.loss;
  }

  @override
  Widget build(BuildContext context) {
    final currentCurrencyCode = context.watch<Currency>().currency;
    final profitProvider = Provider.of<ProfitProvider>(context);
    final lossProvider = Provider.of<LossProvider>(context);

    // Calculate total profit minus loss
    final totalAmount = calculateTotal(profitProvider, lossProvider);

    // Save total to local storage
    profitProvider.saveTotal(totalAmount); // Store total when calculated

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).themeMode ==
                        ThemeMode.light
                    ? const Color(0xffd6722c)
                    : Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Today-${DateFormat('d MMMM yyyy').format(DateTime.now())}',
                      style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FutureBuilder<double>(
                    future: profitProvider
                        .loadTotal(), // Load the total from local storage
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading total');
                      } else {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            
                            '${snapshot.data} $currentCurrencyCode',
                            style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _customCard(
                          color: Colors.green,
                          icon: Icons.arrow_upward,
                          title: 'Profit',
                          subtitle:
                              '$currentCurrencyCode ${profitProvider.profit.toStringAsFixed(2)}',
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _customCard(
                          color: Colors.red,
                          icon: Icons.arrow_downward,
                          title: 'Loss',
                          subtitle:
                              '$currentCurrencyCode ${lossProvider.loss.toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      color: color,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
