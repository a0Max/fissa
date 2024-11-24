import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:fisaa/features/order_puller/presentation/manager/map_of_puller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/widget/button_widget.dart';

class WaitingAcceptFromDriver extends StatelessWidget {
  const WaitingAcceptFromDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          10.ph,
          Text(
            'جاري البحث عن ساحبة',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20.sp),
          ),
          5.ph,
          Text(
            'اسحب الخريطة لتحديد نقطة النهايئة',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontSize: 12.sp),
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Image.asset(
              AppImages.loading,
            ),
          ),
          10.ph,
          ButtonWidget(
            bgColor: Colors.red.shade50,
            textButton: 'إلغاء الرحلة',
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.red),
            onTap: () async {
              await context
                  .read<MapOfPullerProvider>()
                  .cancelTheCurrentTrip(context);
            },
          ),
          30.ph
        ],
      ),
    );
  }
}
