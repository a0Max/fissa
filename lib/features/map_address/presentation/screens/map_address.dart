import 'dart:async';

import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../../core/enums/state_of_search.dart';
import '../../../../core/main_map_informations.dart';
import '../../../../core/utils.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../login/manager/auth_provider.dart';
import '../manager/map_information.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../widget/item_of_search_map.dart';
import '../widget/item_of_search_map.dart';
import '../widget/body_of_bottom_sheet.dart';
import '../widget/search_map_place_widget.dart';

class MapAddress extends StatelessWidget {
  final SelectedHelp typeOfHelp;

  const MapAddress({super.key, required this.typeOfHelp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MapInformation>(
          create: (context) => di.sl<MapInformation>()
            ..submitTypeOfHelp(newTypeOfHelp: typeOfHelp),
          child: Consumer<MapInformation>(builder: (context, state, child) {
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.kGooglePlex?.latitude.toDouble() ??
                          MainMapInformation.latitude,
                      state.kGooglePlex?.longitude.toDouble() ??
                          MainMapInformation.longitude,
                    ),
                    zoom: 14.0,
                  ),
                  polylines: state.polylines, // Add the polylines to the map

                  markers: state.markers,
                  onCameraIdle: () {
                    context.read<MapInformation>().getAddressFromLatLng(
                        state.markers.first.position.latitude,
                        state.markers.first.position.longitude,
                        null,
                        true);
                  },
                  onCameraMove: (position) => context
                      .read<MapInformation>()
                      .changeLocation(position.target),
                  onMapCreated: (GoogleMapController controller) {
                    state.controller.complete(controller);
                    state.gmapController = controller;
                  },
                ),
                if (state.checkEndPoint == false) ...{
                  Positioned(
                      bottom: (MediaQuery.of(context).padding.top + 10),
                      right: (MediaQuery.of(context).padding.right + 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () => context
                                  .read<MapInformation>()
                                  .getUserLocation(),
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: const BoxDecoration(
                                      color: AppColor.mainColor,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.my_location_outlined,
                                    color: Colors.white,
                                  ))),
                          15.ph,
                          ButtonWidget(
                            bgColor: state.startAddress != null &&
                                    state.endAddress != null
                                ? Theme.of(context).primaryColor
                                : AppColor.greyColor,
                            textButton: 'طلب ساحبه',
                            textStyle: Theme.of(context).textTheme.labelLarge!,
                            onTap: state.startAddress != null &&
                                    state.endAddress != null
                                ? () {
                                    context
                                        .read<MapInformation>()
                                        .updateCheckEndPoint(updateCheck: true);
                                    final mapInformation =
                                        context.read<MapInformation>();

                                    Utils.showCustomBottomSheetWithButton(
                                      context,
                                      ChangeNotifierProvider<
                                              MapInformation>.value(
                                          value: mapInformation,
                                          child: BodyOfBottomSheet()),
                                    );
                                    print('startAddress:${state.startAddress}');
                                    print(
                                        'startLocation:${state.startLocation?.lat}-${state.startLocation?.lng}');
                                    print(
                                        'endLocation:${state.endLocation?.lat}-${state.endLocation?.lng}');
                                    print('endAddress:${state.endAddress}');
                                    // Utils.navigateAndRemoveUntilTo(LoginScreen(), context);
                                  }
                                : () {},
                          )
                        ],
                      )),
                  Positioned(
                    top: 0,
                    child: Column(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Column(
                            children: [
                              (MediaQuery.of(context).padding.top + 10).ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  50.pw,
                                  SizedBox(
                                    child: Text(
                                      (state.typeOfHelp ==
                                              SelectedHelp.vehicleTowing)
                                          ? 'سحب مركبة'
                                          : 'نقل بضاعة',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 50.w,
                                      // padding: EdgeInsets.all(20),
                                      child: Icon(Icons.clear),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  5.pw,
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: AppColor.mainColor,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 2,
                                        color: AppColor.lightMainColor,
                                      ),
                                      const Icon(
                                        Icons.circle_outlined,
                                        color: AppColor.lightMainColor,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      SearchMapPlaceWidget(
                                          placeholder: 'نقطة البداية',
                                          text: state.startAddress,
                                          bgColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          textColor: Colors.grey,
                                          iconColor: AppColor.lightGreyColor2,
                                          onSearch: (String text) async {
                                            // print('current text:$text');
                                            context
                                                .read<MapInformation>()
                                                .startSearch(
                                                    text: text,
                                                    latLng: LatLng(
                                                      state.kGooglePlex
                                                              ?.latitude
                                                              .toDouble() ??
                                                          MainMapInformation
                                                              .latitude,
                                                      state.kGooglePlex
                                                              ?.longitude
                                                              .toDouble() ??
                                                          MainMapInformation
                                                              .longitude,
                                                    ),
                                                    radius: 25000);
                                          },
                                          onTapOutside: () {
                                            // context
                                            //     .read<MapInformation>()
                                            //     .saveShowAddress(
                                            //         action: StateOfSearch
                                            //             .endFirstPointSearch);
                                          },
                                          onTap: () {
                                            context
                                                .read<MapInformation>()
                                                .saveShowAddress(
                                                    action: StateOfSearch
                                                        .firstPointSearch);
                                          },
                                          suffixIconOnTap: () {
                                            context
                                                .read<MapInformation>()
                                                .clearStartSearch();
                                          }),
                                      SearchMapPlaceWidget(
                                        placeholder: 'نقطة النهاية',
                                        bgColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        textColor: Colors.grey,
                                        text: state.endAddress,
                                        iconColor: AppColor.lightGreyColor2,
                                        onSearch: (String text) async {
                                          context
                                              .read<MapInformation>()
                                              .startSearch(
                                                  text: text,
                                                  latLng: LatLng(
                                                    state.kGooglePlex?.latitude
                                                            .toDouble() ??
                                                        MainMapInformation
                                                            .latitude,
                                                    state.kGooglePlex?.longitude
                                                            .toDouble() ??
                                                        MainMapInformation
                                                            .longitude,
                                                  ),
                                                  radius: 25000);
                                        },
                                        onTapOutside: () {
                                          // context
                                          //     .read<MapInformation>()
                                          //     .saveShowAddress(
                                          //         action: StateOfSearch
                                          //             .endPointSearch);
                                        },
                                        onTap: () {
                                          context
                                              .read<MapInformation>()
                                              .saveShowAddress(
                                                  action: StateOfSearch
                                                      .endPointSearch);
                                        },
                                        suffixIconOnTap: () {
                                          context
                                              .read<MapInformation>()
                                              .clearEndSearch();
                                        },
                                      ),
                                      10.ph
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (state.locations.isNotEmpty) ...{
                          Container(
                            height: MediaQuery.of(context).size.height - 150.h,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: ListView(
                              children: List.generate(
                                  state.locations.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          // print(
                                          //     'startShowAddress:${context.read<MapInformation>().startShowAddress}');
                                          context
                                              .read<MapInformation>()
                                              .saveStartLocation(
                                                  location: state
                                                      .locations[index]
                                                      .geometry
                                                      ?.location,
                                                  address: state
                                                          .locations[index]
                                                          .formattedAddress ??
                                                      '');
                                        },
                                        child: ItemOfSearchMap(
                                          description: state.locations[index]
                                                  .formattedAddress ??
                                              '',
                                          structuredFormatting: state
                                                  .locations[index]
                                                  .formattedAddress ??
                                              '',
                                        ),
                                      )),
                            ),
                          )
                        }
                      ],
                    ),
                  ),
                },
              ],
            );
          })),
    );
  }
}
