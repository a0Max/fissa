import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/main_map_informations.dart';
import '../../../../core/utils.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../manager/map_of_puller_provider.dart';
import '../widgets/body_of_bottom_sheet_for_puller.dart';

class MapOfPuller extends StatefulWidget {
  @override
  State<MapOfPuller> createState() => _MapOfPullerState();
}

class _MapOfPullerState extends State<MapOfPuller> {
  // final FullLocationModel tempLocationData;
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<MapOfPullerProvider>().showBottomSheet(context);
  //     final mapInformation = context.read<MapOfPullerProvider>();
  //     Utils.showCustomBottomSheetWithButton(
  //       context,
  //       ChangeNotifierProvider<MapOfPullerProvider>.value(
  //           value: mapInformation, child: BodyOfBottomSheetOfPuller()),
  //     );
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Consumer<MapOfPullerProvider>(builder: (context, state, child) {
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

                onMapCreated: (GoogleMapController controller) {
                  state.controller.complete(controller);
                  state.gmapController = controller;
                },
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: state.currentWidget ?? SizedBox(),
                ),
              ),
              // Expanded(
              //     flex: 3,
              //     child: FittedBox(
              //         child: Container(
              //             width: MediaQuery.of(context).size.width * 1.2,
              //             height:
              //                 (MediaQuery.of(context).size.height / (5 + 3)) *
              //                     3.5,
              //             decoration: const BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(16),
              //                 topRight: Radius.circular(16),
              //               ),
              //             ),
              //             // color: Colors.white,
              //             child: state.currentWidget ?? SizedBox())))
            ],
          );
        }),
      ),
    );
  }
}
