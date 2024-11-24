import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/utils.dart';
import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/text_field_widget.dart';
import '../manager/auth_provider.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      appBar: AppBar(),
      floatingActionButton:
          Consumer<AuthProvider>(builder: (context, state, child) {
        return ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              if (!_autoValidate) {
                setState(() => _autoValidate = true);
              }
              return;
            }
            if (state.stateOfLogin == RequestState.loading) return;
            context
                .read<AuthProvider>()
                .loginRequest(phone: _phoneController.text, context: context);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: AppColor.mainColor,
            foregroundColor: AppColor.mainColor,
          ),
          child: state.stateOfLogin == RequestState.loading
              ? CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.arrow_forward, color: Colors.white),
        );
      }),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImages.imageAppIcon,
                    height: 100,
                  ),
                  Column(
                    children: [
                      Text(
                        'مرحباً بك في فيسع',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      15.ph,
                      Text(
                        'يرجى إدخال رقم هاتفك للإستمرار',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            // height: 50.h,
                            child: TextFieldWidget(
                                hintText: 'رقم الهاتف',
                                controler: _phoneController,
                                validatorTextField: (val) =>
                                    ValidationTextField.phoneNumberInput(val),
                                labelText: 'رقم الهاتف',
                                onChanged: (e) {},
                                keyboardType: TextInputType.number,
                                fontSize: 14.sp,
                                borderSideColor:
                                    AppColor.greyColor.withOpacity(.3),
                                fillColor: AppColor.greyColor.withOpacity(.05)),
                          ),
                        ),
                        10.pw,
                        Container(
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                              color: AppColor.greyColor.withOpacity(.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColor.greyColor.withOpacity(.3))),
                          child: Row(
                            children: [
                              Text(
                                '+218',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 14),
                              ),
                              5.pw,
                              Image.asset(
                                AppImages.imageLibyaFlag,
                                height: 25.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox()
                ],
              ),
            )),
      ),
    );
  }
}
