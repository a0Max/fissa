import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/map_address/presentation/manager/map_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/selected_help.dart';
import '../../../../core/utils.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../details_of_transports_goods/presentation/pages/details_of_transports_goods.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../../../order_puller/presentation/manager/map_of_puller_provider.dart';
import '../../../order_puller/presentation/pages/map_of_puller.dart';
import '../../../order_puller/presentation/widgets/check_the_address.dart';
import '../../domain/entities/full_location_model.dart';
import '../../../../core/injection/injection_container.dart' as di;

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
                    locationData: FullLocationModel(
                      endAddress:
                          context.read<MapInformation>().endAddress ?? '',
                      startAddress:
                          context.read<MapInformation>().startAddress ?? '',
                      startLocation:
                          context.read<MapInformation>().startLocation,
                      endLocation: context.read<MapInformation>().endLocation,
                    ),
                  ),
                  context);
            } else {
              MapInformation dataFromProvider = context.read<MapInformation>();
              Utils.navigateTo(
                  ChangeNotifierProvider<MapOfPullerProvider>(
                      create: (context) => MapOfPullerProvider(
                            createTripOfPullerUseCases: di.sl(),
                            getPriceTripOfPullerUseCases: di.sl(),
                            cancelTripOfPullerUseCases: di.sl(),
                            locationService: di.sl(),
                          )..onStartGetDataOfTrip(
                              // context: context,
                              tempUserData:
                                  context.read<AuthProvider>().userData!,
                              tempLocationData: FullLocationModel(
                                  startAddress: dataFromProvider.startAddress,
                                  startLocation: dataFromProvider.startLocation,
                                  endAddress: dataFromProvider.endAddress,
                                  endLocation: dataFromProvider.endLocation)),
                      child: MapOfPuller()),
                  context);
              // context.read<MapInformation>().drawTheDirection();
              // context.read<MapInformation>().updateTheCurrentWidget();
            }
          },
        ),
        30.ph
      ],
    );
  }
}
