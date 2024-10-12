import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/widget/button_widget.dart';

class LoadingBottomSheet extends StatelessWidget {
  const LoadingBottomSheet({super.key});

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
                ?.copyWith(fontSize: 30.sp),
          ),
          5.ph,
          Text(
            'اسحب الخريطة لتحديد نقطة النهايئة',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontSize: 15.sp),
          ),
          10.ph,
          Image.asset(
            AppImages.loading,
          ),
          10.ph,
          ButtonWidget(
            bgColor: Colors.red.shade50,
            textButton: 'إلغاء الرحلة',
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.red),
            onTap: () {},
          ),
          30.ph
        ],
      ),
    );
  }
}
