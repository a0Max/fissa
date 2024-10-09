import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/button_widget.dart';

class CheckTheAddress extends StatelessWidget {
  const CheckTheAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Image.asset(AppImages.puller)),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'ساحبة فيسع',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30.sp),
                  ),
                  Text(
                    'Max 254 kg',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ],
        ),
        ButtonWidget(
          bgColor: Theme.of(context).primaryColor,
          textButton: 'طلب ساحبه',
          textStyle: Theme.of(context).textTheme.labelLarge!,
          onTap: () {},
        ),
        30.ph
      ],
    );
  }
}
