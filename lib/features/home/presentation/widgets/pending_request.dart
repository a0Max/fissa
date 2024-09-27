import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';

class PendingRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
          color: AppColor.lightBlueColor,
          borderRadius: BorderRadius.circular(26)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'قيد الموافقة',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.blueColor),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: AppColor.blueColor, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
