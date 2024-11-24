import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_color.dart';
import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';

class CompleteOfTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                  onPressed: () {
                    Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
                  },
                  icon: Icon(Icons.close)),
            ],
          ),

          // (50).ph,
          Column(
            children: [
              Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(23)),
              ),
              20.ph,
              Text(
                'تم إنشاء الطلب بنجاح',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 25.sp),
              ),
              10.ph,
              Column(
                children: [],
              ),
              Text(
                'Your order is on its way to your address ',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 15.sp),
              ),
            ],
          ),
          10.ph,
          Column(
            children: [
              _itemOfCompleteOrder(context),
              20.ph,
              _itemOfAcceptedOrder(context),
              20.ph,
              _itemOfOnWayOrder(context),
            ],
          ),
          10.ph,
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'تتبع الطلب',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: 20.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
                },
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'الرئيسية',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20.sp),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _itemOfCompleteOrder(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.mainColor),
          child: SvgPicture.asset(AppImages.orderSending),
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إرسال طلب النقل',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              'wait for the collection notification',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 15.sp),
            ),
          ],
        )
      ],
    );
  }

  _itemOfAcceptedOrder(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.grey),
          child: SvgPicture.asset(AppImages.orderAccepted),
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'قبول الطلب من قبل السواق ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              ' items. we started collecting your ',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 15.sp),
            ),
          ],
        )
      ],
    );
  }

  _itemOfOnWayOrder(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.grey),
          child: SvgPicture.asset(AppImages.orderOnWay),
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إرسال طلب النقل',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              'wait for the collection notification',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 15.sp),
            ),
          ],
        )
      ],
    );
  }
}
