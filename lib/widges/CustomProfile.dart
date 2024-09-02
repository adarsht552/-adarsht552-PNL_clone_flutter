import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30.r,
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/default.png',
                  fit: BoxFit.cover,
                  width: 60.r,
                  height: 60.r,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            const Expanded(
              child: ListTile(
                title: Text('User'),
                subtitle: Text("Version title"),
              ),
            ),
            SizedBox(width: 16.w),
           Padding(
            padding:  EdgeInsets.only(right: 10.r),
            child: InkResponse(
              onTap: (){},
              child: Text('Login',style:  TextStyle(color: Colors.blue),)),
          )
          ],
        ),
      ),
    );
  }
}