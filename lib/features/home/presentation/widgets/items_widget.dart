import 'package:fisaa/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/selected_help.dart';
import '../../../map_address/presentation/screens/map_address.dart';
import 'discount_widget.dart';

class ItemsWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final num? discount;
  final SelectedHelp keyOfOption;

  const ItemsWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.keyOfOption,
      this.discount,
      required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.navigateTo(MapAddress(typeOfHelp: keyOfOption), context);
      },
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (discount != null) ...{
                    DiscountcWidget(discount: discount ?? 0),
                  },
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 27),
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Expanded(child: Image.asset(image)),
          ],
        ),
      ),
    );
  }
}
