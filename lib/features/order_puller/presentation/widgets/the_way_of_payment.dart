import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../map_address/presentation/manager/map_information.dart';
import '../manager/map_of_puller_provider.dart';

class TheWayOfPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'وسيلة الدفع',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 30.sp),
            ),
            10.ph,
            _wayToPayment(
              id: 1,
              text: 'نقدي',
              onTap: () {
                context.read<MapOfPullerProvider>().submitWayOfPayment(1);
              },
              subWidget: SizedBox(),
              image: AppImages.money,
              context: context,
              selectedId:
                  context.watch<MapOfPullerProvider>().selectedWayOfPayment,
            ),
            5.ph,
            _wayToPayment(
              id: 2,
              context: context,
              text: 'بطاقة xxx',
              onTap: () {},
              subWidget: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: AppColor.yellowColor),
                child: Text(
                  'قريباً',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 11.sp),
                ),
              ),
              image: null,
              selectedId:
                  context.watch<MapOfPullerProvider>().selectedWayOfPayment,
            ),
            10.ph,
            Consumer<MapOfPullerProvider>(builder: (context, state, child) {
              return state.stateOfCreateTrip == RequestState.loading
                  ? Center(child: CupertinoActivityIndicator())
                  : ButtonWidget(
                      bgColor: Theme.of(context).primaryColor,
                      textButton: 'طلب ساحبه',
                      textStyle: Theme.of(context).textTheme.labelLarge!,
                      onTap: () {
                        context.read<MapOfPullerProvider>().createTripDetails();
                      },
                    );
            }),
          ],
        ));
  }

  _wayToPayment({
    required String? image,
    required String text,
    required void Function() onTap,
    required int id,
    required Widget subWidget,
    required int selectedId,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: id == selectedId
                ? AppColor.mainColor.withOpacity(.2)
                : Colors.white,
            border: Border.all(
                color: id == selectedId
                    ? AppColor.mainColor
                    : AppColor.lightGreyColor2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (image != null) ...{
                  Image.asset(
                    image,
                    width: 20,
                  ),
                } else ...{
                  20.pw
                },
                10.pw,
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 20.sp),
                ),
              ],
            ),
            subWidget,
          ],
        ),
      ),
    );
  }
}
