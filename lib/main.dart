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
                  home: IntroScreen(),
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
