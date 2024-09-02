import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/CurrencyProvider.dart';

class CurrencyModel {
  final String name;
  final String code;
  final String symbol;
  final IconData flagIcon;

  CurrencyModel({
    required this.name,
    required this.code,
    required this.symbol,
    required this.flagIcon,
  });
}

class CurrencyBottomSheet extends StatefulWidget {
  const CurrencyBottomSheet({Key? key}) : super(key: key);

  @override
  _CurrencyBottomSheetState createState() => _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends State<CurrencyBottomSheet> {
  final List<CurrencyModel> _currencies = [
    CurrencyModel(name: 'United States Dollar', code: 'USD', symbol: '\$', flagIcon: Icons.flag),
    CurrencyModel(name: 'Euro', code: 'EUR', symbol: '€', flagIcon: Icons.flag),
    CurrencyModel(name: 'British Pound', code: 'GBP', symbol: '£', flagIcon: Icons.flag),
    // Add more currencies as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Access the current currency from the provider
    final currentCurrencyCode = context.watch<Currency>().currency;

    // Find the corresponding CurrencyModel for the current currency
    final currentCurrency = _currencies.firstWhere(
      (currency) => currency.code == currentCurrencyCode,
      orElse: () => CurrencyModel(name: 'Unknown', code: 'Unknown', symbol: '', flagIcon: Icons.error),
    );

    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.sp)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Your Currency (${currentCurrency.name} ${currentCurrency.symbol})',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                final currency = _currencies[index];
                final isSelected = currentCurrencyCode == currency.code;

                return ListTile(
                  leading: Icon(currency.flagIcon, color: Colors.blueGrey),
                  title: Text(
                    '${currency.name} (${currency.symbol})',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    currency.code,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.check_circle_outline,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  onTap: () {
                    // Update the selected currency in the provider
                    context.read<Currency>().changeCurrency(currency.code);
                    Navigator.pop(context); // Close the bottom sheet after selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
