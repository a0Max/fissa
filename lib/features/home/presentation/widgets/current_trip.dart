import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/home/presentation/widgets/steps_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pending_request.dart';

class CurrentTrip extends StatelessWidget {
  final int currentStep;
  CurrentTrip({super.key, required this.currentStep})
      : assert(() {
          if (currentStep == 0) {
            throw FlutterError(
              "currentStep can't be zero",
            );
          }
          return true;
        }());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: FittedBox(
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.furniture,
                      width: 40,
                    ),
                    10.pw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'أثاث / فرش',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 13),
                            children: <TextSpan>[
                              TextSpan(
                                text: '(100 ك.ج)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Text('رقم الطلب BFF34223',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              )),
              Expanded(child: PendingRequest(currentStep: currentStep)),
            ],
          ),
          10.ph,
          Divider(
            color: AppColor.lightGreyColor2.withOpacity(.3),
          ),
          10.ph,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: StepsLine(totalSteps: 4, currentStep: (currentStep - 1)),
          ),
          10.ph,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'شارع المدار, طرابلس ليبيا',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 12.sp),
                    ),
                    Text(
                      '1:34 PM 2 March',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'شارع المدار, طرابلس ليبيا',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 12.sp),
                    ),
                    Text(
                      '1:34 PM 2 March',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.ph,
          const Divider(
            color: AppColor.lightGreyColor2,
          ),
          10.ph,
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColor.yellowColor,
                ),
                10.pw,
                Text(
                  'تفاصيل الطلب',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
