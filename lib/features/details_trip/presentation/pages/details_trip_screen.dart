import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../../core/enums/state_of_ride.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../manager/details_trip_provider.dart';

class DetailsTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsTripProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: Text(
            '#${state.currentTrip.id}-${state.currentTrip.status}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
        body: Column(
          children: [
            _appOfTrip(context, state.currentTrip),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${state.currentTrip.price} دل",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image.asset(
                                      TypeExtension.mapOfSelectedHelp()[
                                                  state.currentTrip.typeId] ==
                                              SelectedHelp.vehicleTowing
                                          ? AppImages.pullerCarUi
                                          : AppImages.carGoods,
                                      width: 120.w,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.carPlate))),
                                      child: Text(
                                        state.currentTrip.driver?.carRequests
                                                ?.first.plateNum ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                                10.ph,
                                Text(
                                  state.currentTrip.getTheDateFormat(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "السواق",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 18.sp),
                        ),
                        15.ph,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColor.lightGreyColor3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                      imageUrl: 'image' ?? '',
                                      height: 50.h,
                                      progressIndicatorBuilder: (x, b, c) {
                                        return const CupertinoActivityIndicator();
                                      },
                                      imageBuilder: (x, y) {
                                        return CircleAvatar(
                                            child: Image.asset(
                                                AppImages.imageDriver));
                                      },
                                      errorWidget: (context, url, error) {
                                        return CircleAvatar(
                                            child: Image.asset(
                                          AppImages.imageDriver,
                                          fit: BoxFit.fill,
                                          // width: 50,
                                        ));
                                      }),
                                  10.pw,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.currentTrip.driver?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(fontSize: 18.sp)),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: AppColor.mainColor),
                                            color: AppColor.lightMainColor2),
                                        child: Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: (state.currentTrip.review
                                                            ?.averageRating ??
                                                        '0')
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(fontSize: 10.sp),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(Icons.star,
                                                color: AppColor.yellowColor,
                                                size: 16),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  20.pw,
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "tel://${state.currentTrip.driver?.countryCode}${state.currentTrip.driver?.phone}"));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      // width: MediaQuery.of(context).size.width / 4,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Transform.flip(
                                            flipX: true,
                                            child: const Icon(
                                              CupertinoIcons.phone_fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                          5.pw,
                                          Text(
                                            'اتصال',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(fontSize: 13.sp),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.pw,
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    // width: MediaQuery.of(context).size.width / 4,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: const Icon(
                                        Icons.message,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  20.pw,
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.ph,
                  Container(
                    color: AppColor.lightGreyColor3,
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.ph,
                        Text(
                          "السواق",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 18.sp),
                        ),
                        15.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "النـــــوع",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                            Text(
                              state.currentTrip.stuffType?.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الـــوزن",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                            Text(
                              state.currentTrip.weight?.weight ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  15.ph,
                  Container(
                    color: AppColor.lightGreyColor3,
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.ph,
                            Text(
                              "تفاصيل الرحلة",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                            10.ph,
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailsTripProvider>()
                                    .changeShowFirst();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColor.mainColor,
                                        child: FittedBox(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      10.pw,
                                      Text(
                                        "تفاصيل الرحلة",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    state.showFirst
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ],
                              ),
                            ),
                            if (state.showFirst == true) ...{
                              Row(
                                children: [
                                  9.pw,
                                  Container(
                                    width: 2,
                                    height: 100,
                                    color: AppColor.mainColor,
                                  ),
                                  10.pw,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColor.lightGreyColor3)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            const Icon(
                                              Icons.location_on_rounded,
                                              color: AppColor.mainColor,
                                            ),
                                            Container(
                                              height: 70.h,
                                              width: 2,
                                              color: AppColor.lightMainColor,
                                            ),
                                            const Icon(
                                              Icons.circle_outlined,
                                              color: AppColor.lightMainColor,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "من",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(fontSize: 15.sp),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100.w,
                                              child: Text(
                                                state.currentTrip.from ?? '',
                                                overflow: TextOverflow.visible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(fontSize: 15.sp),
                                              ),
                                            ),
                                            Text(
                                              "إلى",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(fontSize: 15.sp),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100.w,
                                              child: Text(
                                                state.currentTrip.to ?? '',
                                                overflow: TextOverflow.visible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(fontSize: 15.sp),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            },
                            15.ph,
                          ])),
                  15.ph,
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.ph,
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailsTripProvider>()
                                    .changeShowSecond();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColor.mainColor,
                                        child: FittedBox(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      10.pw,
                                      Text(
                                        "نقطة النهاية",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    state.showSecond
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ],
                              ),
                            ),
                            if (state.showSecond == true) ...{
                              Row(
                                children: [
                                  9.pw,
                                  Container(
                                    width: 2,
                                    height: 100,
                                    color: AppColor.mainColor,
                                  ),
                                  10.pw,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColor.lightGreyColor3)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.user2,
                                                  height: 15.h,
                                                ),
                                                10.pw,
                                                Text(
                                                  state.currentTrip
                                                          .receiverName ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            5.ph,
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              color: AppColor.lightGreyColor3,
                                              height: 2,
                                            ),
                                            5.ph,
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: AppColor.mainColor,
                                                ),
                                                10.pw,
                                                Text(
                                                    state.currentTrip
                                                            .receiverPhone ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchUrl(Uri.parse(
                                                "tel://${state.currentTrip.driver?.countryCode}${state.currentTrip.receiverPhone}"));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green),
                                                color: Colors.green.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            // width: MediaQuery.of(context).size.width / 4,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.flip(
                                                  flipX: true,
                                                  child: const Icon(
                                                      CupertinoIcons.phone_fill,
                                                      color: Colors.green),
                                                ),
                                                5.pw,
                                                Text(
                                                  'اتصال',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                          fontSize: 13.sp,
                                                          color: Colors.green),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            },
                            15.ph,
                          ]))
                ],
              ),
            ),
            state.stateOfCancel == RequestState.loading
                ? CupertinoActivityIndicator()
                : _buttonOfTripDetails(context, state.currentTrip),
            20.ph,
          ],
        ),
      );
    });
  }
  // _detailsAboutThe

  Widget _appOfTrip(BuildContext context, TripDetailsModel currentTrip) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      color: currentTrip.status == StateOfRide.searching.text()
          ? AppColor.yellowColor
          : AppColor.greenColor,
      child: Text(
        currentTrip.status == StateOfRide.searching.text()
            ? 'الحالة : ● يتم الان البحث عن سائق ⌕'
            : 'الحالة : بضاعتك يتم الان توصيلها  ⛟',
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buttonOfTripDetails(
      BuildContext context, TripDetailsModel currentTrip) {
    return currentTrip.status == StateOfRide.searching.text()
        ? ButtonWidget(
            bgColor: Colors.red.shade100,
            textButton: 'تكرار الطلب',
            textStyle: Theme.of(context).textTheme.labelLarge!,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close, color: Colors.red),
                10.pw,
                Text(
                  'إلغاء الطلب',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                )
              ],
            ),
          )
        : ButtonWidget(
            bgColor: Theme.of(context).primaryColor,
            textButton: 'تكرار الطلب',
            textStyle: Theme.of(context).textTheme.labelLarge!,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.reorder,
                  height: 15.h,
                ),
                10.pw,
                Text(
                  'تكرار الطلب',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
          );
  }
}
