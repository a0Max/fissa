import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _goToHomeScreen();
  }

  void _goToHomeScreen() async {
    await context
        .read<AuthProvider>()
        .isThereTokenAvailableHere(context: context);
    //   Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
    // }, whenUserDataIsNotAvailable: () {
    //   Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          // SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Image.asset(AppImages.imageIconWithText),
          ),
          Image.asset(AppImages.imageTracksIntro)
        ],
      ),
    );
  }
}
