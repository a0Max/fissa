import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';
import '../../../../core/assets_images.dart';

class StepsLine extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepsLine(
      {super.key, required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // _disActivePoint(currentStep: currentStep, index: 0),
        currentStep == 0
            ? _firstStepWidget(context: context)
            : _disActivePoint(index: 1, currentStep: currentStep),
        _linesOfLoadingStep(currentStep: currentStep, lineStep: 1),
        currentStep == 1
            ? _secondStepWidget(context: context)
            : _disActivePoint(index: 2, currentStep: currentStep),
        _linesOfLoadingStep(currentStep: currentStep, lineStep: 2),

        currentStep == 2
            ? _thirdStepWidget(context: context)
            : _disActivePoint(index: 3, currentStep: currentStep),
        _linesOfLoadingStep(currentStep: currentStep, lineStep: 3),
        _disActivePoint(currentStep: currentStep, index: 3),
      ],
    );
  }

  _linesOfLoadingStep({required int currentStep, required int lineStep}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Divider(
          color: currentStep == lineStep
              ? AppColor.mainColor
              : AppColor.lightGreyColor2,
        ),
      ),
    );
  }

  _disActivePoint({required int currentStep, required int index}) {
    return Container(
      child: CircleAvatar(
        radius: 5.w,
        backgroundColor: currentStep >= index
            ? AppColor.mainColor
            : AppColor.lightGreyColor2,
      ),
    );
  }

  _secondStepWidget({required context}) {
    return FittedBox(
      child: CircleAvatar(
        radius: 20.w,
        backgroundColor: AppColor.mainColor,
        child: Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset(AppImages.cars)),
      ),
    );
  }

  _firstStepWidget({required context}) {
    return FittedBox(
      child: Column(
        children: [
          CircleAvatar(
            radius: 20.w,
            backgroundColor: AppColor.mainColor,
            child: Container(
                padding: const EdgeInsets.all(5), child: Icon(Icons.search)),
          ),
        ],
      ),
    );
  }

  _thirdStepWidget({required context}) {
    return FittedBox(
      child: CircleAvatar(
        radius: 20.w,
        backgroundColor: AppColor.mainColor,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppImages.boxThirdStep)),
      ),
    );
  }
}
