import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/Provider/profitProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stock/widges/common/TextField.dart';

class ProfitLoss extends StatefulWidget {
  ProfitLoss({Key? key}) : super(key: key);

  @override
  _ProfitLossState createState() => _ProfitLossState();
}

class _ProfitLossState extends State<ProfitLoss> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _profitController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profitProvider = Provider.of<ProfitProvider>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          height: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Enter Profit", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, size: 40.h,color: Colors.green,),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: DateFormat('MM-dd').format(DateTime.now()),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  color: Colors.green,
                  hint: 'Profit',
                  controller: _profitController,
                
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    onPressed: () {
                      // Save the date and profit in the provider
                      if (_selectedDate != null && _profitController.text.isNotEmpty) {
                        profitProvider.setSelectedDate(_dateController.text);
                        profitProvider.setProfit(double.parse(_profitController.text));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
