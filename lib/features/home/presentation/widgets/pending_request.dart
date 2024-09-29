import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';

class PendingRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColor.lightBlueColor,
          borderRadius: BorderRadius.circular(26)),
      child: FittedBox(
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
            10.pw,
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: AppColor.blueColor, shape: BoxShape.circle),
            )
          ],
        ),
      ),
    );
  }
}
