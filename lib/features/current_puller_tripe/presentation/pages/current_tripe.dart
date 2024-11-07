import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/app_color.dart';
import '../../../../core/enums/state_of_ride.dart';
import '../../../../core/main_map_informations.dart';
import '../manager/current_trip_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentTripeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CurrentTripProvider>(builder: (context, state, child) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: state.polylines,

              initialCameraPosition:
                  CameraPosition(target: state.origin, zoom: 7),
              markers: state.markers,
              onMapCreated: (GoogleMapController controller) {
                state.controller.complete(controller);
                state.gmapController = controller;
                context.read<CurrentTripProvider>().saveContext(context);
              },
              // initialCameraPosition: CameraPosition(
              //   target: LatLng(
              //     state.kGooglePlex?.latitude.toDouble() ??
              //         MainMapInformation.latitude,
              //     state.kGooglePlex?.longitude.toDouble() ??
              //         MainMapInformation.longitude,
              //   ),
              //   zoom: 14.0,
              // ),
              // onMapCreated: (GoogleMapController controller) {
              //   state.controller.complete(controller);
              //   state.gmapController = controller;
              // },
            ),
            Positioned(
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        MediaQuery.of(context).padding.top.ph,
                        if (state.currentTripData == null) ...{
                          _theDriverOnTheWay(context)
                        } else ...{
                          state.currentTripData?.getTheStateOfTrip() ==
                                  StateOfRide.way
                              ? _theDriverOnTheWay(context)
                              : _youAreOnTheTrip(context),
                        }
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
                                const BoxShadow(
                                  color: Color(0x38000000),
                                  blurRadius: 30,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ]),
                          child: const Icon(
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
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
                                width: MediaQuery.of(context).size.width -
                                    (16 * 2),
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
                                                          AppImages
                                                              .imageDriver));
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
                                                Text(
                                                    state.dataOfTrip.driverId
                                                            ?.name ??
                                                        '',
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
                                                    const SizedBox(width: 5),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: (state
                                                                    .dataOfTrip
                                                                    ?.driverReviews
                                                                    ?.averageRating ??
                                                                '')
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontSize:
                                                                    10.sp),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                "(${(state.dataOfTrip?.driverReviews?.totalRating ?? '').toString()}+تقييم)",
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
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Image.asset(
                                              AppImages.pullerCarUi,
                                              width: 120.w,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          AppImages.carPlate))),
                                              child: Text(
                                                state
                                                        .dataOfTrip
                                                        .driverId
                                                        ?.carRequests
                                                        ?.first
                                                        .plateNum ??
                                                    '',
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
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: AppColor.lightGreyColor3,
                              ),
                              10.ph,
                              if (state.currentTripData == null) ...{
                                _theCallingOnTheWay(context)
                              } else ...{
                                state.currentTripData?.getTheStateOfTrip() ==
                                        StateOfRide.way
                                    ? _theCallingOnTheWay(context)
                                    : _theCallingOnTheTrip(context),
                              }
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey.shade100,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
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
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: AppColor.mainColor,
                                  ),
                                  10.pw,
                                  Expanded(
                                    child: Text(
                                      state.dataOfTrip.tripDetails?.from ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 15.sp,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              20.ph,
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.yellowColor),
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                    ),
                                  ),
                                  10.pw,
                                  Expanded(
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 50.h,
                                    child: Text(
                                      state.dataOfTrip.tripDetails?.to ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 15.sp,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w400),
                                    ),
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
                          padding: const EdgeInsets.only(right: 16, top: 16),
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
                                            text: state.dataOfTrip?.tripDetails
                                                    ?.price
                                                    .toString() ??
                                                '',
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
        );
      }),
    );
  }

  Widget _theDriverOnTheWay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: AppColor.blueColor),
        10.pw,
        Text(
          'السائق سيصل إليك بعد',
          style:
              Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18.sp),
        ),
        10.pw,
        Consumer<CurrentTripProvider>(builder: (context, state, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.blueColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${state.currentTripData?.etaMinutes ?? state.dataOfTrip.etaMinutes ?? 0} دقيقة',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 15.sp),
            ),
          );
        }),
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
    return Consumer<CurrentTripProvider>(builder: (context, state, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(
                  "tel://${state.dataOfTrip.driverId?.countryCode}${state.dataOfTrip.driverId?.phone}"));
            },
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.phone),
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
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.message,
                  color: Colors.black,
                ),
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
          GestureDetector(
            onTap: () async {
              await context
                  .read<CurrentTripProvider>()
                  .cancelTheCurrentTrip(context);
            },
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.pinkColor.withOpacity(.3),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
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
    });
  }

  Widget _theCallingOnTheTrip(BuildContext context) {
    return Consumer<CurrentTripProvider>(builder: (context, state, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          20.pw,
          Expanded(
            child: GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(
                    "tel://${state.dataOfTrip?.driverId?.countryCode}${state.dataOfTrip?.driverId?.phone}"));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50)),
                // width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          20.pw,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50)),
              // width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
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
    });
  }
}
