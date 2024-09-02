import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock/widges/common/TextField.dart';

class HomeFlotingBotton extends StatelessWidget {
   HomeFlotingBotton({super.key});

final TextEditingController Email = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Select a Type",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10.h,),
               _customcard( color: Colors.green,icon: Icons.face, title: 'Profit', onTap: () {}),
               SizedBox(height: 10.h,),
               _customcard(color:Colors.red,icon: Icons.downhill_skiing, title: 'Loss', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _customcard({
  required String title,
  required VoidCallback onTap,
  required IconData? icon,
  required Color? color,
}) {
  return Card(
    color: color,
    child: Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    ),
  );
}
