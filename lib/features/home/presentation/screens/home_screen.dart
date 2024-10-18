import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/home/presentation/manager/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/app_color.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../login/manager/auth_provider.dart';
import '../../domain/entities/trips_model.dart';
import '../widgets/current_trip.dart';
import '../widgets/items_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyColor,
      body: ChangeNotifierProvider<HomeProvider>(
        create: (context) => di.sl<HomeProvider>(),
        child: Stack(
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
                        icon: Image.asset(AppImages.notifications),
                        onPressed: () {},
                      ),
                    ],
                    leading: IconButton(
                      icon: Image.asset(AppImages.chatWithSupport),
                      onPressed: () {},
                    ),
                  ),
                  50.ph,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً بك في فيسع',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      fontSize: 20, color: Colors.white38),
                            ),
                            Image.asset(
                              AppImages.handOfHome,
                              height: 30,
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
                        child: Consumer<HomeProvider>(
                            builder: (context, state, child) {
                          return Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    state.homeData?.categories?.length ?? 0,
                                    (index) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ItemsWidget(
                                                  title: state
                                                          .homeData
                                                          ?.categories?[index]
                                                          .title ??
                                                      '', //'سحب مركبـــة',
                                                  subTitle: state
                                                          .homeData
                                                          ?.categories?[index]
                                                          .shortTitle ??
                                                      '', //'ســاحبة',
                                                  image: AppImages.vehicle,
                                                  discount: state
                                                              .homeData
                                                              ?.categories?[
                                                                  index]
                                                              .isDiscount ==
                                                          1
                                                      ? (state
                                                          .homeData
                                                          ?.categories?[index]
                                                          .discount)
                                                      : 0,
                                                  keyOfOption: TypeExtension
                                                          .mapOfSelectedHelp()[
                                                      state
                                                          .homeData
                                                          ?.categories?[index]
                                                          .id]),
                                              10.ph,
                                            ])),
                                20.ph,
                                Text(
                                  'رحلاتي الحالية',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColor.lightPurpleColor),
                                ),
                                10.ph,
                                ...List.generate(
                                    state.homeData?.trips?.length ?? 0,
                                    (index) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CurrentTrip(
                                                data: state.homeData
                                                        ?.trips?[index] ??
                                                    TripsModel(),
                                              ),
                                              10.ph,
                                            ])),
                              ]);
                        }),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
