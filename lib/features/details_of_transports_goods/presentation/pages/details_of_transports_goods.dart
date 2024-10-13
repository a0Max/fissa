import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../login/manager/auth_provider.dart';
import '../manager/manager_of_transport_goods.dart';
import '../widgets/step_line_of_transport_goods.dart';

class DetailsOfTransportsGoods extends StatelessWidget {
  final String endPointAddress;

  const DetailsOfTransportsGoods({super.key, required this.endPointAddress});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagerOfTransportGoods>(
        create: (context) =>
            ManagerOfTransportGoods(endPointAddress: endPointAddress),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColor.mainColor,
                )),
            title: Text(
              'تفاصيل النقلة',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ),
          body:
              Consumer<ManagerOfTransportGoods>(builder: (context, state, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1E000000),
                            blurRadius: 26,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          10.ph,
                          StepLineOfTransportsGoods(
                            currentStep: (state.indexOfStep + 1),
                          ),
                          15.ph,
                        ],
                      ),
                    ),
                    20.ph,
                    Container(
                        color: Colors.white,
                        child: state.widgetsOfSteps[state.indexOfStep])
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ManagerOfTransportGoods>()
                                    .updateIndexOfStepToDownGrade();
                              },
                              child: Container(
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColor.lightMainColor3,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  'السابق',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ),
                          20.w.pw,
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ManagerOfTransportGoods>()
                                    .updateIndexOfStep();
                              },
                              child: Container(
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: state.stateOfNextButton
                                        ? AppColor.mainColor
                                        : AppColor.greyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'إستمرار',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontSize: 20.sp),
                                    ),
                                    10.pw,
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      40.ph,
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}