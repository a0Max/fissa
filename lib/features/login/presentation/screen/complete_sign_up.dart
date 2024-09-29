import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';

class CompleteSignUp extends StatelessWidget {
  const CompleteSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27),
            color: Colors.white,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: -90,
                child: Image.asset(
                  AppImages.imageTopPartOfComplete,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "تم تفعيل حسابك ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 44),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'بنجـــاح',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 44, color: Colors.green)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    FittedBox(
                      child: Text(
                        'قم بطلب توصيلتك بسهولة ووفر وقتك وجهدك',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 18),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -25,
                child: ElevatedButton(
                  onPressed: () {
                    Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: AppColor.mainColor,
                    foregroundColor: AppColor.mainColor,
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
