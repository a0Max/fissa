import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'core/main_map_informations.dart';
import 'core/theme.dart';
import 'features/current_puller_tripe/presentation/manager/current_trip_provider.dart';
import 'features/current_puller_tripe/presentation/pages/current_tripe.dart';
import 'features/details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'features/intro/presentation/screen/intro_screen.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/login/presentation/manager/auth_provider.dart';
import 'features/login/presentation/screen/login_screen.dart';
import 'features/order_puller/domain/entities/data_of_trip_puller_model.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(
              getUserDataUseCases: di.sl(),
              getStuffTypesDataUseCases: di.sl(),
              addRequiredDataUseCases: di.sl(),
              checkOtpUseCases: di.sl(),
              loginUseCases: di.sl(),
            ),
          ),
          // di.sl<AuthProvider>(),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return Consumer<AuthProvider>(builder:
                  (BuildContext context, AuthProvider auth, Widget? child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: AppTheme.getLightTheme(),
                  themeMode: ThemeMode.light,
                  debugShowCheckedModeBanner: false,
                  home: ChangeNotifierProvider<CurrentTripProvider>(
                      create: (_) => di.sl<CurrentTripProvider>()
                        ..saveTripData(
                            tempDataOfTrip: DataOfTripePullerModel(
                                tripDetails: TripDetailsModel(
                          fromLat: "30.03360161365462",
                          fromLng: "31.368464939296246",
                          toLat: "31.241764513705757",
                          toLng: "29.959890134632584",
                        ))),
                      child: CurrentTripeScreen()),
                  builder: (context, widget) {
                    return Directionality(
                      textDirection:
                          TextDirection.rtl, // Set the text direction to RTL
                      child: widget!,
                    );
                  },
                );
              });
            }));
  }
}
