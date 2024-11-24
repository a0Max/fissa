import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.green.shade50),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.checkmark,
            color: Colors.green,
            size: 15.sp,
          ),
          5.pw,
          Text(
            'مكتمل',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.green,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
