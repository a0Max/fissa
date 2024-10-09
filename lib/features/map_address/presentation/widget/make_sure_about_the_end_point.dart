import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/button_widget.dart';

class MakeSureAboutTheEndPoint extends StatelessWidget {
  const MakeSureAboutTheEndPoint({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
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
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
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
    );
  }
}
