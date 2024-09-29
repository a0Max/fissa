import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/utils.dart';
import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/text_field_widget.dart';
import 'complete_sign_up.dart';

class EmailScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  EmailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Utils.navigateAndRemoveUntilTo(CompleteSignUp(), context);
          // context.read<AuthProvider>().startCountdown();
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
          padding: EdgeInsets.symmetric(horizontal: 20),
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الرجاء إدخال بريدك الالكتروني (إختياري)',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 21),
                      textAlign: TextAlign.end,
                    ),
                    15.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFieldWidget(
                              hintText: 'البريد الالكترونى',
                              controler: _emailController,
                              validatorTextField: (val) =>
                                  ValidationTextField.phoneNumberInput(val),
                              labelText: 'البريد الالكترونى',
                              onChanged: (e) {},
                              keyboardType: TextInputType.text,
                              fontSize: 14,
                              borderSideColor:
                                  AppColor.greyColor.withOpacity(.1),
                              fillColor: AppColor.greyColor.withOpacity(.05),
                              leftWidget: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  AppImages.iconMail,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
