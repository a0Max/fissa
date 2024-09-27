import 'package:fisaa/core/assets_images.dart';
import 'package:flutter/material.dart';

import 'discount_widget.dart';

class ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(child: Image.asset(AppImages.vehicle)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DiscountcWidget(),
                Text(
                  'سحب مركبـــة',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 27),
                ),
                Text(
                  'ســاحبة',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
