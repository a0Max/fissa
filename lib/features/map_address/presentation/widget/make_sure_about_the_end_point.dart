import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/button_widget.dart';
import '../manager/map_information.dart';

class MakeSureAboutTheEndPoint extends StatelessWidget {
  const MakeSureAboutTheEndPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: Colors.white,
      alignment: Alignment.center,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          10.ph,
          Text(
            'تأكيد نقطة النهاية',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'اسحب الخريطة لتحديد نقطة النهايئة',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 18.sp),
          ),
          25.ph,
          ButtonWidget(
            bgColor: Theme.of(context).primaryColor,
            textButton: 'إستمرار',
            textStyle: Theme.of(context).textTheme.labelLarge!,
            onTap: () {},
          ),
          30.ph
        ],
      ),
    );
  }
}
