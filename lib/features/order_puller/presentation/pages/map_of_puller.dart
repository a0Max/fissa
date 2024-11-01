import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/main_map_informations.dart';
import '../../../../core/utils.dart';
import '../../../current_puller_tripe/presentation/manager/current_trip_provider.dart';
import '../../../current_puller_tripe/presentation/pages/current_tripe.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../manager/map_of_puller_provider.dart';
import '../widgets/body_of_bottom_sheet_for_puller.dart';

class MapOfPuller extends StatefulWidget {
  @override
  State<MapOfPuller> createState() => _MapOfPullerState();
}

class _MapOfPullerState extends State<MapOfPuller> {
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.fullTripDetailsWithDriver != null) {
              print(
                  "myProvider.fullTripDetailsWithDriver:${state.fullTripDetailsWithDriver?.tripDetails?.price}");
              print(
                  "myProvider.fullTripDetailsWithDriver:${state.fullTripDetailsWithDriver?.driverId?.name}");
              Utils.navigateAndRemoveUntilTo(
                  ChangeNotifierProvider<CurrentTripProvider>(
                      create: (_) => di.sl<CurrentTripProvider>()
                        ..saveTripData(
                            tempDataOfTrip: state.fullTripDetailsWithDriver!),
                      child: CurrentTripeScreen()),
                  context);
            }
          });
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                polylines: state.polylines,
                initialCameraPosition:
                    CameraPosition(target: state.origin, zoom: 7),
                markers: state.markers,
                onMapCreated: (GoogleMapController controller) {
                  state.controller.complete(controller);
                  state.gmapController = controller;
                  state.drawTheDirection();
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
