import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme.dart';
import 'features/intro/presentation/screen/intro_screen.dart';
import 'features/login/manager/auth_provider.dart';
import 'features/login/presentation/screen/login_screen.dart';
import 'features/login/presentation/screen/otp_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
            create: (context) => AuthProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.getLightTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}
