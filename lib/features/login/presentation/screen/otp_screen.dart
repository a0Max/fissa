import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/utils.dart';
import '../manager/auth_provider.dart';
import 'name_screen.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      appBar: AppBar(),
      floatingActionButton:
          Consumer<AuthProvider>(builder: (context, state, child) {
        return ElevatedButton(
          onPressed: () async {
            if (state.stateOfOtp == RequestState.loading) return;
            context.read<AuthProvider>().doneOtp(_controller.text, context);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: AppColor.mainColor,
            foregroundColor: AppColor.mainColor,
          ),
          child: state.stateOfOtp == RequestState.loading
              ? CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.arrow_forward, color: Colors.white),
        );
      }),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                        child: FittedBox(
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
                            maxLength: 5,
                            hasError: false,
                            pinBoxColor: AppColor.greyColor.withOpacity(.1),
                            pinBoxRadius: 13,
                            pinBoxBorderWidth: 1,
                            onTextChanged: (text) {
                              context
                                  .read<AuthProvider>()
                                  .updateCurrentOtp(char: text);
                            },
                            onDone: (text) async {
                              // checkOTP();
                              await context
                                  .read<AuthProvider>()
                                  .doneOtp(text, context);
                            },
                            pinBoxWidth:
                                (MediaQuery.of(context).size.width - 200) / 4,
                            pinBoxHeight:
                                (MediaQuery.of(context).size.width - 200) / 4,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
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
                              context
                                  .read<AuthProvider>()
                                  .resentOtp(context: context);
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
