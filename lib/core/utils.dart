import 'package:fisaa/core/vars.dart';
import 'package:fisaa/core/widget/button_widget.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';

import '../features/map_address/presentation/manager/map_information.dart';

class Utils {
  static Future<void> navigateTo(Widget screen, BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  static void navigateAndRemoveUntilTo(Widget child, BuildContext context,
          {bool rootNavigator = false}) async =>
      Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => child,
          ),
          (route) => false);

  static void navigateToAndReplacement(Widget child, BuildContext context) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => child));

  static void showCustomBottomSheetWithButton(
      BuildContext mainContext, Widget child) {
    showModalBottomSheet(
      context: mainContext,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.
            // clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ButtonWidget(
                  width: 50,
                  bgColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).primaryColor),
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).primaryColor),
                  onTap: () {
                    mainContext
                        .read<MapInformation>()
                        .updateCheckEndPoint(updateCheck: false);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              10.ph,
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: child,
                // ),
              )
            ],
          ),
        );
      },
    );
  }

  static void showMainBottomSheetWithButton(
      BuildContext mainContext, Widget child) {
    showModalBottomSheet(
      context: mainContext,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
