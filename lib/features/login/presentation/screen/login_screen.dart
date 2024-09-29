import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/utils.dart';
import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/text_field_widget.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Utils.navigateAndRemoveUntilTo(OtpScreen(), context);
          context.read<AuthProvider>().startCountdown();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: AppColor.mainColor,
          foregroundColor: AppColor.mainColor,
        ),
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
      body: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
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
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFieldWidget(
                            hintText: 'رقم الهاتف',
                            controler: _phoneController,
                            validatorTextField: (val) =>
                                ValidationTextField.phoneNumberInput(val),
                            labelText: 'رقم الهاتف',
                            onChanged: (e) {},
                            keyboardType: TextInputType.number,
                            fontSize: 14,
                            borderSideColor: AppColor.greyColor.withOpacity(.3),
                            fillColor: AppColor.greyColor.withOpacity(.05)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
