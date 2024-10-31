import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/button_widget.dart';
import '../../../map_address/presentation/manager/map_information.dart';
import '../manager/map_of_puller_provider.dart';

class CheckTheAddress extends StatelessWidget {
  const CheckTheAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final mapInformation = context.read<MapOfPullerProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ساحبة فيسع',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 25.sp),
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
                  Expanded(child: Image.asset(AppImages.puller)),
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
                  Row(
                    children: [
                      Image.asset(AppImages.requestStartEndLocation),
                      10.pw,
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mapInformation.locationData?.startAddress ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 16.sp),
                            ),
                            Text(
                              mapInformation.locationData?.endAddress ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        "${context.watch<MapOfPullerProvider>().priceOfTripe ?? ''} دل",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.ph,
          ],
        ),
        ButtonWidget(
          bgColor: Theme.of(context).primaryColor,
          textButton: 'طلب ساحبه',
          textStyle: Theme.of(context).textTheme.labelLarge!,
          onTap: () {
            context.read<MapOfPullerProvider>().updateTheIndex();
          },
        ),
      ],
    );
  }
}
