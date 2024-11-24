import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.red.shade50),
      child: Row(
        children: [
          Icon(
            Icons.close,
            color: Colors.red,
            size: 15.sp,
          ),
          5.pw,
          Text(
            'ملغية',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
