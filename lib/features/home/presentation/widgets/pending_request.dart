import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';

class PendingRequest extends StatelessWidget {
  final int currentStep;

  const PendingRequest({super.key, required this.currentStep});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColor.lightPurpleColor2,
          borderRadius: BorderRadius.circular(26)),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _textWillDisplay(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor.mainColor),
            ),
            10.pw,
            Container(
              // width: 10,
              // height: 10,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.lightMainColor2, shape: BoxShape.circle),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: AppColor.mainColor, shape: BoxShape.circle),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _textWillDisplay() {
    switch (currentStep) {
      case 1:
        return 'البحث عن سائق';
      case 2:
        return 'في الطريق إليك';
      case 3:
        return ' يتم تحميل البضاعة';
    }
    return '';
  }
}
