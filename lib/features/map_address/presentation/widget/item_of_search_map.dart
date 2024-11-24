import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';

class ItemOfSearchMap extends StatelessWidget {
  final String description;
  final String structuredFormatting;

  const ItemOfSearchMap(
      {super.key,
      required this.description,
      required this.structuredFormatting});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          10.pw,
          Icon(
            Icons.location_on_outlined,
            color: AppColor.lightGreyColor2,
          ),
          15.pw,
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15.sp, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start),
                5.ph,
                Text(structuredFormatting.split(",").last,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 13.sp, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start)
              ],
            ),
          )
        ],
      ),
    );
  }
}
