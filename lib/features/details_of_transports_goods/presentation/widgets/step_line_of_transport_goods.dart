import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';

class StepLineOfTransportsGoods extends StatelessWidget {
  final int currentStep;

  const StepLineOfTransportsGoods({super.key, required this.currentStep});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          _firstStepWidget(context: context, keyIndex: 1),
          _linesOfLoadingStep(currentStep: currentStep, lineStep: 2),
          _firstStepWidget(context: context, keyIndex: 2),
          _linesOfLoadingStep(currentStep: currentStep, lineStep: 3),
          _firstStepWidget(context: context, keyIndex: 4),
        ],
      ),
    );
  }

  _firstStepWidget({required context, required int keyIndex}) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
          color: keyIndex < currentStep
              ? AppColor.mainColor
              : AppColor.lightGreyColor3,
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.mainColor, width: 2)),
      child: keyIndex < currentStep
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
    );
  }

  _linesOfLoadingStep({required int currentStep, required int lineStep}) {
    return Expanded(
      child: Container(
        height: 3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: (currentStep == 3 && lineStep != 3)
              ? AppColor.mainColor
              : lineStep <= currentStep
                  ? AppColor.mainColor
                  : AppColor.lightGreyColor2,
          gradient: currentStep == 3 && lineStep == 3
              ? LinearGradient(colors: [
                  AppColor.mainColor,
                  AppColor.lightGreyColor2,
                  AppColor.lightGreyColor2
                ], begin: Alignment.centerRight, end: Alignment.centerLeft)
              : null,
        ),
        margin: const EdgeInsets.only(right: 10, left: 10),
      ),
    );
  }
}
