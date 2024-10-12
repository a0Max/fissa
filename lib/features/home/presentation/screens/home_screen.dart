import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';
import '../../../../core/enums/selected_help.dart';
import '../widgets/current_trip.dart';
import '../widgets/items_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyColor,
      body: Stack(
        children: [
          Image.asset(
            AppImages.bgHomeScreen,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                      icon: Image.asset(AppImages.chatWithSupport),
                      onPressed: () {},
                    ),
                  ],
                  leading: IconButton(
                    icon: Image.asset(AppImages.notifications),
                    onPressed: () {},
                  ),
                ),
                50.ph,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppImages.handOfHome,
                            height: 30,
                          ),
                          Text(
                            'مرحباً بك في فيسع',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 20, color: Colors.white38),
                          ),
                        ],
                      ),
                      Text(
                        'كيف نقدر نساعدك !',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 30),
                      )
                    ],
                  ),
                ),
                10.ph,
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height / 3)),
                    child: SingleChildScrollView(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ItemsWidget(
                                    title: 'سحب مركبـــة',
                                    subTitle: 'ســاحبة',
                                    image: AppImages.vehicle,
                                    discount: 50,
                                    keyOfOption: SelectedHelp.vehicleTowing,
                                  ),
                                  10.ph,
                                  ItemsWidget(
                                    title: 'نقل بضاعـــة',
                                    subTitle: 'بورتل',
                                    image: AppImages.transportOfGoods,
                                    keyOfOption: SelectedHelp.transportOfGoods,
                                  ),
                                  10.ph
                                ]),
                            20.ph,
                            Text(
                              'رحلاتي الحالية',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColor.lightPurpleColor),
                            ),
                            10.ph,
                            CurrentTrip(currentStep: 1),
                            CurrentTrip(currentStep: 2),
                            CurrentTrip(currentStep: 3),
                          ]),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
