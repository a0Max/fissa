import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/app_color.dart';

class CurrentTripeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(32.8872, 13.1913), // Replace with actual coordinates
              zoom: 14,
            ),
            zoomControlsEnabled: false,
          ),

          // Top Info Banner
          Positioned(
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      MediaQuery.of(context).padding.top.ph,
                      _youAreOnTheTrip(context),
                    ],
                  ),
                ),
                10.ph,
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x38000000),
                                blurRadius: 30,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                    10.pw,
                  ],
                )
              ],
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.25,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              height: 7,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            20.ph,
                            Container(
                              width:
                                  MediaQuery.of(context).size.width - (16 * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('معلومات الرحلة',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 18.sp)),
                                  15.ph,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CachedNetworkImage(
                                              imageUrl: 'image' ?? '',
                                              height: 50.h,
                                              progressIndicatorBuilder:
                                                  (x, b, c) {
                                                return const CupertinoActivityIndicator();
                                              },
                                              imageBuilder: (x, y) {
                                                return CircleAvatar(
                                                    child: Image.asset(
                                                        AppImages.imageDriver));
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return CircleAvatar(
                                                    child: Image.asset(
                                                  AppImages.imageDriver,
                                                  // height: 100,
                                                  // width: 50,
                                                ));
                                              }),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('علي عبدالله',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontSize: 18.sp)),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16),
                                                  SizedBox(width: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "5.0",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 10.sp),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "(100+تقييم)",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      10.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: context
                                                    .read<AuthProvider>()
                                                    .stuffTypesData
                                                    ?.types
                                                    ?.first
                                                    .image ??
                                                '',
                                            height: 50.h,
                                            progressIndicatorBuilder:
                                                (x, b, c) {
                                              return const CupertinoActivityIndicator();
                                            },
                                            imageBuilder: (x, y) {
                                              return CircleAvatar(
                                                  child: Image.asset(
                                                      AppImages.imageDriver));
                                            },
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        AppImages.carPlate))),
                                            child: Text(
                                              '5-34566',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(fontSize: 14.sp),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColor.lightGreyColor3,
                            ),
                            10.ph,
                            _theCallingOnTheTrip(context),
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey.shade100,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الرحلة',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 23.sp),
                            ),
                            10.ph,
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: AppColor.mainColor,
                                ),
                                10.pw,
                                Text(
                                  'مجمع المحاكم حي الاندلس',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            20.ph,
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.yellowColor),
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                                10.pw,
                                Text(
                                  'مجمع المحاكم حي الاندلس',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey.shade100,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16, top: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'التكلفة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 23.sp),
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "24.00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(fontSize: 31.sp),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'دل',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontSize: 20.sp)),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(child: Image.asset(AppImages.price))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _theDriverOnTheWay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: AppColor.blueColor),
        10.pw,
        Text(
          'السائق سيصل إليك بعد',
          style:
              Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18.sp),
        ),
        10.pw,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.blueColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '25 دقيقة',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 15.sp),
          ),
        ),
      ],
    );
  }

  Widget _youAreOnTheTrip(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        AppImages.activeTripe,
        height: 20.h,
      ),
      10.pw,
      Text(
        'أنت خلال الرحلة',
        style:
            Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18.sp),
      ),
    ]);
  }

  Widget _theCallingOnTheWay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Icon(Icons.phone),
                backgroundColor: Colors.green,
              ),
              10.ph,
              Text(
                'إتصـــل',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 13.sp),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.message,
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey.shade300,
              ),
              10.ph,
              Text(
                'رســـالة',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 13.sp),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                backgroundColor: AppColor.pinkColor.withOpacity(.3),
              ),
              10.ph,
              Text(
                'إلغاء',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 13.sp),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _theCallingOnTheTrip(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        20.pw,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(50)),
            // width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.flip(
                  flipX: true,
                  child: Icon(
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
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50)),
            // width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.flip(
                  flipX: true,
                  child: Icon(
                    Icons.message,
                    color: Colors.black,
                  ),
                ),
                5.pw,
                Text(
                  'رسالة',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 13.sp),
                )
              ],
            ),
          ),
        ),
        20.pw,
      ],
    );
  }
}
