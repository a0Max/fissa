import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FourthStepDetails extends StatelessWidget {
  const FourthStepDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      height: MediaQuery.of(context).size.height - 240.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ManagerOfTransportGoods>(builder: (context, state, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ph,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Text(
                            'مسار الرحلة',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            // width: 100,
                            // height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.yellowColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(30)),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'تعديل',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const Icon(
                                    Icons.edit,
                                    color: AppColor.yellowColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'من:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.mainColor.withOpacity(.2),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width / 3),
                                    child: Text(
                                      state.locationData.startAddress ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 13.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          5.pw,
                          Expanded(
                            child: Container(
                              color: AppColor.lightGreyColor3,
                              height: 50,
                            ),
                          ),
                          5.pw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'إلى:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle_outlined,
                                    color: AppColor.mainColor.withOpacity(.2),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      state.locationData.endAddress ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 13.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage(AppImages.pathOfTransportGoods))),
                      // child:,
                    )
                  ],
                ),
              ),
              20.ph,
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: 200.h,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      10.ph,
                      FittedBox(
                        child: Text(
                          'تفاصيل البضاعة',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.mainColor.withOpacity(.5)),
                        ),
                      ),
                      10.ph,
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.goods),
                              10.pw,
                              RichText(
                                text: TextSpan(
                                  text: state.selectTypeOfGood?.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 15.sp),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          state.selectWeightOfGood?.title ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColor.mainColor,
                          )
                        ],
                      ),
                      10.ph,
                      const Divider(
                        color: AppColor.lightGreyColor3,
                      ),
                      15.ph,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 130.h,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                child: SizedBox(
                                  height: 130.h,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _circleLocation(),
                                      5.ph,
                                      Expanded(
                                        child: Container(
                                          width: 5,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      5.ph,
                                      _circleLocation(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildCustomListItemSender(context, state),
                                  // 10.ph,
                                  _buildCustomListItemReceiver(context, state),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      15.ph,
                      const Divider(
                        color: AppColor.lightGreyColor3,
                      ),
                      15.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'خدمات التحميل',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            // width: 100,
                            // height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.yellowColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(30)),
                            child: FittedBox(
                              child: Text(
                                (state.needWorkers ?? 0) > 0
                                    ? '${state.needWorkers} عمّــال'
                                    : 'لا أريد عمّــال',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      15.ph,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCustomListItemReceiver(
      BuildContext context, ManagerOfTransportGoods state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المستقبل',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.mainColor.withOpacity(.5)),
        ),
        10.ph,
        Row(
          children: [
            Text(
              state.textFieldNameOfReceiver ?? 'dfsfs',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  state.textFieldPhoneOfReceiver ?? '3224234',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                10.pw,
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100, shape: BoxShape.circle),
                    child: Icon(
                      Icons.phone_sharp,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildCustomListItemSender(
      BuildContext context, ManagerOfTransportGoods state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المرسل',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.mainColor.withOpacity(.5)),
        ),
        10.ph,
        Row(
          children: [
            Text(
              context.read<AuthProvider>().userData?.fname ?? 'dfsfs',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  context.read<AuthProvider>().userData?.phone ?? '3224234',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                10.pw,
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100, shape: BoxShape.circle),
                    child: Icon(
                      Icons.phone_sharp,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  _circleLocation() {
    return Container(
      height: 20.h,
      width: 20.h,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: AppColor.mainColor.withOpacity(.2)),
      child: Container(
        // height: 10.h,
        // width: 10.h,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColor.mainColor),
      ),
    );
  }
}
