import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme.dart';
import 'features/intro/presentation/screen/intro_screen.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/login/presentation/manager/auth_provider.dart';
import 'features/login/presentation/screen/login_screen.dart';
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
                  home: DraggableMapScreen(),
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

class DraggableMapScreen extends StatelessWidget {
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
            top: 40,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'السائق سيصل إليك بعد',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '25 دقيقة',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.location_on, color: Colors.white),
                ],
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 100,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.all(16),
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
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Header of the bottom sheet
                    Container(
                      width: 50,
                      height: 5,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'معلومات الرحلة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Image.asset(
                          'assets/truck_icon.png', // Replace with actual asset path
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'علي عبدالله',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 5),
                        Text('5.0 (100+ تقييم)'),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Contact Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.cancel, color: Colors.red, size: 30),
                            SizedBox(height: 5),
                            Text('إلغاء', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.message, color: Colors.black, size: 30),
                            SizedBox(height: 5),
                            Text('رسالة'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.phone, color: Colors.green, size: 30),
                            SizedBox(height: 5),
                            Text('إتصال',
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ],
                    ),

                    Divider(),

                    // Trip Information
                    SizedBox(height: 10),
                    Text(
                      'الرحلة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.blue),
                      title: Text('مجمع الحاكم حي الاندلس'),
                      subtitle: Text('H7EDD'),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.orange),
                      title: Text('مجمع الحاكم حي الاندلس'),
                      subtitle: Text('H7EDD'),
                    ),

                    Divider(),

                    // Cost Information
                    SizedBox(height: 10),
                    Text(
                      'التكلفة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.monetization_on, color: Colors.green),
                      title: Text(
                        '24.00 د.ل',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text('ملاحظات هنا ملاحظات هنا ملاحظات هنا'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
