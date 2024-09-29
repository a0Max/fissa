import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/home/presentation/widgets/steps_line.dart';
import 'package:flutter/material.dart';
import 'pending_request.dart';

class CurrentTrip extends StatelessWidget {
  const CurrentTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
              Expanded(child: PendingRequest()),
              Expanded(
                  child: FittedBox(
                child: Row(
                  children: [
                    Column(
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
                    10.pw,
                    Image.asset(
                      AppImages.furniture,
                      width: 40,
                    )
                  ],
                ),
              )),
            ],
          ),
          10.ph,
          Divider(
            color: AppColor.lightGreyColor2.withOpacity(.3),
          ),
          10.ph,
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: const StepsLine(totalSteps: 4, currentStep: 1),
            ),
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
                          ?.copyWith(fontSize: 12),
                    ),
                    Text(
                      '1:34 PM 2 March',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10),
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
                          ?.copyWith(fontSize: 12),
                    ),
                    Text(
                      '1:34 PM 2 March',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10),
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
                Text(
                  'تفاصيل الطلب',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                10.pw,
                const Icon(
                  Icons.info_outline,
                  color: AppColor.yellowColor,
                )
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
