import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/widget/button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          10.ph,
          10.ph,
          10.ph,
          10.ph,
          10.ph,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Image.asset(AppImages.imageIconWithText),
              ),
              Text(
                'مرحباً بك في فيسع',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              20.ph,
              ButtonWidget(
                bgColor: Theme.of(context).hintColor,
                textButton: 'طلب توصيلة',
                textStyle: Theme.of(context).textTheme.labelLarge!,
                onTap: () {},
              ),
              10.ph,
              ButtonWidget(
                bgColor: AppColor.lightMainColor,
                textButton: 'سائق فيسع',
                textStyle: Theme.of(context).textTheme.labelLarge!,
                onTap: () {},
              ),
            ],
          ),
          Image.asset(
            AppImages.imageArrowsIntro,
            height: MediaQuery.of(context).size.height / 3,
          ),
        ],
      ),
    );
  }
}
