import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/utils.dart';
import '../../manager/auth_provider.dart';
import 'name_screen.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Utils.navigateAndRemoveUntilTo(NameScreen(), context);
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Consumer<AuthProvider>(builder: (context, state, __) {
            return Column(
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
                      'كود التحقق',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    15.ph,
                    Text(
                      'يرجى إدخال الرمز المرسل عبر الهاتف',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: PinCodeTextField(
                          isCupertino: true,
                          autofocus: true,
                          controller: _controller,
                          highlight: true,
                          highlightColor: AppColor.greyColor.withOpacity(.1),
                          defaultBorderColor:
                              AppColor.greyColor.withOpacity(.1),
                          hasTextBorderColor: AppColor.mainColor,
                          pinTextStyle: Theme.of(context).textTheme.bodySmall,
                          maxLength: 6,
                          hasError: false,
                          pinBoxColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          pinBoxRadius: 13,
                          pinBoxBorderWidth: 1,
                          onTextChanged: (text) {
                            // _otp = text;
                            context
                                .read<AuthProvider>()
                                .updateCurrentOtp(char: text);
                          },
                          onDone: (text) {
                            // checkOTP();
                            context.read<AuthProvider>().doneOtp(context);
                          },
                          pinBoxWidth:
                              (MediaQuery.of(context).size.width - 180) / 4,
                          pinBoxHeight: 60,
                          wrapAlignment: WrapAlignment.spaceAround,
                          pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              const Duration(milliseconds: 300),
                          highlightAnimationBeginColor: Colors.black,
                          highlightAnimationEndColor: Colors.white12,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    20.ph,
                    Text(
                      'ثانية ${"${(state.initialCountdownSeconds ~/ 60).toString().padLeft(2, '0')}:${(state.initialCountdownSeconds % 60).toString().padLeft(2, '0')}"}',
                      textAlign:
                          TextAlign.center, // Align the text to the center
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: state.reSendCode == false
                              ? AppColor.mainColor
                              : AppColor.greyColor),
                    ),
                    GestureDetector(
                      onTap: state.reSendCode
                          ? () {
                              context.read<AuthProvider>().startCountdown();
                            }
                          : null,
                      child: Text(
                        'إعادة الإرسال',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: state.reSendCode
                                ? AppColor.mainColor
                                : AppColor.greyColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox()
              ],
            );
          }),
        ),
      ),
    );
  }
}
