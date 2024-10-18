import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';
import 'gradient_boarder.dart';

class DiscountcWidget extends StatelessWidget {
  final num discount;

  const DiscountcWidget({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return UnicornOutlineButton(
      gradient: LinearGradient(
        colors: [AppColor.pinkColor, AppColor.lightRedColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      strokeWidth: 2,
      radius: 15,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [AppColor.pinkColor, AppColor.lightRedColor],
            )),
        child: Text(
          'تخفيض $discount% ',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 11),
        ),
      ),
    );
  }
}
