import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/main_map_informations.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../login/manager/auth_provider.dart';
import '../manager/map_information.dart';
import '../manager/search_location_cubit.dart';
import '../widget/widget_search_map_place_updated/search_map_place_updated.dart';
import '../../../../core/injection/injection_container.dart' as di;

class MapAddress extends StatelessWidget {
  const MapAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MapInformation>(
          create: (context) => MapInformation(),
          child: Consumer<MapInformation>(
              builder: (context, MapInformation state, child) {
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
                  top: 0,
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    color: Colors.white,
                    child: Column(
                      children: [
                        (MediaQuery.of(context).padding.top + 10).ph,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                BlocProvider<SearchLocationCubit>(
                                    create: (_) => di.sl<SearchLocationCubit>(),
                                    child: SearchMapPlaceWidget(
                                      apiKey: MainMapInformation.mapKey,
                                      location: LatLng(
                                        state.kGooglePlex?.latitude
                                                .toDouble() ??
                                            MainMapInformation.latitude,
                                        state.kGooglePlex?.longitude
                                                .toDouble() ??
                                            MainMapInformation.longitude,
                                      ),
                                      radius: 2000,
                                      placeholder: 'نقطة البداية',
                                      bgColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      textColor: Colors.grey,
                                      iconColor: AppColor.lightGreyColor2,
                                      onSearch: (String text) async {
                                        di
                                            .sl<SearchLocationCubit>()
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
                                                radius: 2000);
                                      },
                                      onSelected: (Place place) async {},
                                    )),
                                // SearchMapPlaceWidget(
                                //   apiKey: MainMapInformation.mapKey,
                                //   location: LatLng(
                                //     state.kGooglePlex?.latitude.toDouble() ??
                                //         MainMapInformation.latitude,
                                //     state.kGooglePlex?.longitude.toDouble() ??
                                //         MainMapInformation.longitude,
                                //   ),
                                //   radius: 2000,
                                //   placeholder: 'نقطة النهاية',
                                //   bgColor:
                                //       Theme.of(context).scaffoldBackgroundColor,
                                //   textColor: Colors.grey,
                                //   iconColor: AppColor.lightGreyColor2,
                                //   onSearch: (Place place) async {},
                                //   onSelected: (Place place) async {},
                                // ),
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
                        )
                      ],
                    ),
                  ),
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
                    ))
              ],
            );
          })),
    );
  }
}
