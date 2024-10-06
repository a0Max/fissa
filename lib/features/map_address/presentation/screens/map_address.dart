import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/main_map_informations.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../login/manager/auth_provider.dart';
import '../manager/map_information.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../widget/item_of_search_map.dart';
import '../widget/item_of_search_map.dart';
import '../widget/search_map_place_widget.dart';

class MapAddress extends StatelessWidget {
  const MapAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MapInformation>(
          create: (context) => di.sl<MapInformation>(),
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
                  markers: state.markers,
                  onCameraMove: (position) => context
                      .read<MapInformation>()
                      .changeLocation(position.target),
                  onMapCreated: (GoogleMapController controller) {
                    state.controller.complete(controller);
                    state.gmapController = controller;
                  },
                ),
                Positioned(
                    bottom: (MediaQuery.of(context).padding.top + 10),
                    left: (MediaQuery.of(context).padding.left + 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () => context
                                .read<MapInformation>()
                                .getUserLocation(),
                            child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.my_location_outlined,
                                  color: Colors.white,
                                ))),
                        15.ph,
                        ButtonWidget(
                          bgColor: Theme.of(context).primaryColor,
                          textButton: 'طلب ساحبه',
                          textStyle: Theme.of(context).textTheme.labelLarge!,
                          onTap: () {
                            // Utils.navigateAndRemoveUntilTo(LoginScreen(), context);
                          },
                        )
                      ],
                    )),
                Positioned(
                  top: 0,
                  child: Column(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                          children: [
                            (MediaQuery.of(context).padding.top + 10).ph,
                            Row(
                              children: [
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
                                                  state.kGooglePlex?.latitude
                                                          .toDouble() ??
                                                      MainMapInformation
                                                          .latitude,
                                                  state.kGooglePlex?.longitude
                                                          .toDouble() ??
                                                      MainMapInformation
                                                          .longitude,
                                                ),
                                                radius: 15000);
                                      },
                                      onTapOutside: () {
                                        context
                                            .read<MapInformation>()
                                            .saveShowAddress(action: false);
                                      },
                                      onTap: () {
                                        context
                                            .read<MapInformation>()
                                            .saveShowAddress(action: true);
                                      },
                                    ),
                                    SearchMapPlaceWidget(
                                      placeholder: 'نقطة النهاية',
                                      bgColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      textColor: Colors.grey,
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
                                                radius: 15000);
                                      },
                                      onTapOutside: () {
                                        context
                                            .read<MapInformation>()
                                            .saveEndShowAddress(action: false);
                                      },
                                      onTap: () {
                                        context
                                            .read<MapInformation>()
                                            .saveEndShowAddress(action: true);
                                      },
                                    ),
                                    10.ph
                                  ],
                                )),
                                Column(
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    Container(
                                      height: 20.h,
                                      width: 2,
                                      color: AppColor.lightGreyColor2,
                                    ),
                                    Icon(Icons.circle_outlined),
                                  ],
                                ),
                                5.pw
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
                                        context
                                            .read<MapInformation>()
                                            .saveStartLocation(
                                                location: state.locations[index]
                                                    .geometry?.location,
                                                address: state.locations[index]
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
              ],
            );
          })),
    );
  }
}
