import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/button_widget.dart';
import '../manager/map_information.dart';

class CheckTheAddress extends StatelessWidget {
  const CheckTheAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final mapInformation = context.read<MapInformation>();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(child: Image.asset(AppImages.puller)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: AppColor.lightGreyColor2,
            )),
        Container(
          height: 70.h,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "التكلفة",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    "24.00 دل",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 18.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mapInformation.startAddress ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16.sp),
                        ),
                        Text(
                          mapInformation.endAddress ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  10.pw,
                  Image.asset(AppImages.requestStartEndLocation),
                ],
              ),
            ],
          ),
        ),
        10.ph,
        ButtonWidget(
          bgColor: Theme.of(context).primaryColor,
          textButton: 'طلب ساحبه',
          textStyle: Theme.of(context).textTheme.labelLarge!,
          onTap: () {
            context.read<MapInformation>().updateTheCurrentWidget();
          },
        ),
        30.ph
      ],
    );
  }
}
