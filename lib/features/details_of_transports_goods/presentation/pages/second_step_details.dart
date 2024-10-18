import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/text_field_widget.dart';
import '../widgets/type_of_good.dart';

class SecondStepDetails extends StatelessWidget {
  SecondStepDetails({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Consumer<ManagerOfTransportGoods>(builder: (context, state, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.ph,
                  Row(
                    children: [
                      Image.asset(
                        AppImages.aIcon,
                        height: 15.h,
                      ),
                      10.pw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'معلومات المرسل',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.mainColor,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text(
                                  state.locationData.endAddress ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 14.sp),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  18.ph,
                ],
              ),
            ),
            10.ph,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اسم المستقبل',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      5.ph,
                      SizedBox(
                        height: 40.h,
                        child: TextFieldWidget(
                          hintText: '',
                          controler: _nameController,
                          validatorTextField: (val) =>
                              ValidationTextField.textInput(val),
                          labelText: '',
                          onChanged: (e) {
                            context
                                .read<ManagerOfTransportGoods>()
                                .updateNameOfReceiver(newText: e);
                          },
                          keyboardType: TextInputType.text,
                          fontSize: 14.sp,
                          borderSideColor: AppColor.greyColor.withOpacity(.1),
                          fillColor: AppColor.greyColor.withOpacity(.05),
                          leftWidget: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              AppImages.personIcon,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم الهاتف',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      5.ph,
                      SizedBox(
                        height: 40.h,
                        child: TextFieldWidget(
                          hintText: '',
                          controler: _phoneController,
                          validatorTextField: (val) =>
                              ValidationTextField.phoneNumberInput(val),
                          labelText: '',
                          onChanged: (e) {
                            context
                                .read<ManagerOfTransportGoods>()
                                .updatePhoneOfReceiver(newText: e);
                          },
                          keyboardType: TextInputType.text,
                          fontSize: 14.sp,
                          borderSideColor: AppColor.greyColor.withOpacity(.1),
                          fillColor: AppColor.greyColor.withOpacity(.05),
                          leftWidget: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              AppImages.phoneIcon,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            15.ph,
            Divider(
              color: AppColor.lightGreyColor2.withOpacity(.3),
              indent: 20,
              endIndent: 20,
            ),
            10.ph,
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<ManagerOfTransportGoods>()
                        .updatePayWhenReceive();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.h,
                        // paddi/ng: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: state.payWhenReceive
                                ? AppColor.mainColor
                                : Colors.white,
                            border: Border.all(
                                color: state.payWhenReceive
                                    ? AppColor.mainColor
                                    : AppColor.lightGreyColor2,
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: state.payWhenReceive
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15.sp,
                              )
                            : SizedBox(),
                      ),
                      10.pw,
                      Text(
                        'الدفع عند المرسل',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 15.sp),
                      )
                    ],
                  ),
                )),
            10.ph,
            Divider(
              color: AppColor.lightGreyColor2.withOpacity(.3),
            ),
          ],
        );
      }),
    );
  }
}
