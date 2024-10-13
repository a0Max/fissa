import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:fisaa/features/map_address/presentation/manager/map_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/selected_help.dart';
import '../../../../core/utils.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../details_of_transports_goods/presentation/pages/details_of_transports_goods.dart';

class MakeSureAboutTheEndPoint extends StatelessWidget {
  const MakeSureAboutTheEndPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.ph,
        Text(
          'تأكيد نقطة النهاية',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'اسحب الخريطة لتحديد نقطة النهايئة',
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
        ),
        25.ph,
        ButtonWidget(
          bgColor: Theme.of(context).primaryColor,
          textButton: 'إستمرار',
          textStyle: Theme.of(context).textTheme.labelLarge!,
          onTap: () {
            if (context.read<MapInformation>().typeOfHelp ==
                SelectedHelp.transportOfGoods) {
              Utils.navigateTo(
                  DetailsOfTransportsGoods(
                    endPointAddress:
                        context.read<MapInformation>().endAddress ?? '',
                  ),
                  context);
            } else {
              context.read<MapInformation>().drawTheDirection();
              context.read<MapInformation>().updateTheCurrentWidget();
            }
          },
        ),
        30.ph
      ],
    );
  }
}
