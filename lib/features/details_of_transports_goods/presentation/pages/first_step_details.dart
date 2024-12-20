import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../intro/domain/entities/get_stuff_types_model.dart';
import '../../../intro/domain/entities/get_weight_model.dart';
import '../widgets/type_of_good.dart';

class FirstStepDetails extends StatelessWidget {
  const FirstStepDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                Text(
                  'ما هو نوع البضاعة؟',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 23.sp, fontWeight: FontWeight.w600),
                ),
                18.ph,
                Consumer<ManagerOfTransportGoods>(
                    builder: (context, state, __) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        context
                                .read<AuthProvider>()
                                .stuffTypesData
                                ?.types
                                ?.length ??
                            0,
                        (index) => TypeOfGood(
                              title: context
                                      .read<AuthProvider>()
                                      .stuffTypesData
                                      ?.types?[index]
                                      .name ??
                                  '',
                              image: context
                                  .read<AuthProvider>()
                                  .stuffTypesData
                                  ?.types?[index]
                                  .image,
                              goodKey: context
                                      .read<AuthProvider>()
                                      .stuffTypesData
                                      ?.types?[index]
                                      .id ??
                                  0,
                              onTap: () {
                                context
                                    .read<ManagerOfTransportGoods>()
                                    .updateSelectTypeOfGood(
                                        typeOfGood: (context
                                                .read<AuthProvider>()
                                                .stuffTypesData
                                                ?.types?[index] ??
                                            GetStuffTypesModel()));
                              },
                              currentKey: state.selectTypeOfGood?.id ?? 0,
                            )),
                  );
                })
              ],
            ),
          ),
          10.ph,
          Container(
            height: 10,
            color: AppColor.lightGreyColor3,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                Text(
                  'كم وزن البضاعة (تقريباً)',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 23.sp, fontWeight: FontWeight.w600),
                ),
                18.ph,
                Container(
                    height: 30.h,
                    child: Consumer<ManagerOfTransportGoods>(
                        builder: (context, state, __) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            context
                                    .read<AuthProvider>()
                                    .stuffTypesData
                                    ?.weight
                                    ?.length ??
                                0,
                            (index) => Row(
                                  children: [
                                    TypeOfGood(
                                      title: context
                                              .read<AuthProvider>()
                                              .stuffTypesData
                                              ?.weight?[index]
                                              .weight ??
                                          '',
                                      goodKey: context
                                              .read<AuthProvider>()
                                              .stuffTypesData
                                              ?.weight?[index]
                                              .id ??
                                          0,
                                      onTap: () {
                                        context
                                            .read<ManagerOfTransportGoods>()
                                            .updateSelectWeightOfGood(
                                                typeOfGood: (context
                                                        .read<AuthProvider>()
                                                        .stuffTypesData
                                                        ?.weight?[index] ??
                                                    GetWeightModel()));
                                      },
                                      currentKey:
                                          state.selectWeightOfGood?.id ?? 0,
                                    ),
                                    10.pw,
                                  ],
                                )),
                      );
                    }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
