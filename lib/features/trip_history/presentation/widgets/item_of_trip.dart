import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../../core/enums/state_of_ride.dart';
import '../../../../core/utils.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../details_trip/presentation/manager/details_trip_provider.dart';
import '../../../details_trip/presentation/pages/details_trip_screen.dart';

class ItemOfTrip extends StatelessWidget {
  final TripDetailsModel item;
  const ItemOfTrip({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.navigateTo(
            ChangeNotifierProvider<DetailsTripProvider>(
                create: (context) => DetailsTripProvider(
                      currentTrip: item,
                      cancelTripOfPullerUseCases: di.sl(),
                    ),
                child: DetailsTripScreen()),
            context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.lightGreyColor3)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.asset(
                        TypeExtension.mapOfSelectedHelp()[item.typeId] ==
                                SelectedHelp.vehicleTowing
                            ? AppImages.pullerCarUi
                            : AppImages.carGoods,
                        width: 120.w,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.carPlate))),
                        child: Text(
                          item.driver?.carRequests?.first.plateNum ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontSize: 14.sp),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      TypeExtensionOfStateOfRide.widgetUi(
                          type: item.status.toString()),
                      5.ph,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: AppColor.lightPurpleColor3,
                          ),
                          Text(
                            item.getTheDateFormat(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 14.sp),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColor.lightGreyColor2,
                )),
            FittedBox(
              child: Container(
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
                                item.from ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 16.sp),
                              ),
                              Text(
                                item.to ?? '',
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
                          "الأجرة",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16.sp),
                        ),
                        Text(
                          "${item.price} دل",
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
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
