import 'package:flutter/material.dart';

import '../../../../core/assets_images.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
