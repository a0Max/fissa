import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/injection/injection_container.dart' as di;

import '../../../../core/utils.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../manager/rate_driver_provider.dart';

class RateDiverScreen extends StatelessWidget {
  final int idOfTrip;

  const RateDiverScreen({super.key, required this.idOfTrip});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<RateDriverProvider>(
          create: (_) => di.sl<RateDriverProvider>(),
          child: Consumer<RateDriverProvider>(builder: (context, state, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MediaQuery.of(context).padding.top.ph,
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close,
                          color: AppColor.mainColor, size: 30),
                      onPressed: () {
                        Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'تمت الرحلة بنجاح',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30.sp),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    AppImages.endOfTrip,
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'كيف كانت الرحلة؟',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 23.sp),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Morem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 20),
                  Transform.flip(
                    flipX: true,
                    child: RatingStars(
                      value: state.rate,
                      onValueChanged: (v) {
                        context.read<RateDriverProvider>().updateTheRate(v);
                      },
                      starCount: 5,
                      starSize: 40.sp,
                      valueLabelColor: Colors.grey.shade100,
                      maxValue: 5,
                      starSpacing: 5,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      animationDuration: Duration(milliseconds: 1000),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: AppColor.yellowColor,
                    ),
                  ),
                  Spacer(),
                  state.stateOfRate == RequestState.loading
                      ? Center(child: CupertinoActivityIndicator())
                      : ButtonWidget(
                          bgColor: state.rate == 0
                              ? Colors.grey.shade300
                              : Theme.of(context).primaryColor,
                          textButton: 'إنهاء',
                          textStyle: Theme.of(context).textTheme.labelLarge!,
                          onTap: () {
                            if (state.rate != 0) {
                              context
                                  .read<RateDriverProvider>()
                                  .cancelTheCurrentTrip(context, idOfTrip);
                            }
                          },
                        ),
                  SizedBox(height: 20),
                ],
              ),
            );
          })),
    );
  }
}
