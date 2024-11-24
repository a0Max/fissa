import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';

class DefaultWidget extends StatelessWidget {
  final String state;

  const DefaultWidget({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColor.mainColor.withOpacity(.1)),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.arrow_right_arrow_left_circle,
            color: AppColor.mainColor,
            size: 15.sp,
          ),
          5.pw,
          Text(
            state,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColor.mainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
