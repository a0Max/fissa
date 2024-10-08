import 'package:fisaa/core/widget/button_widget.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
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
      BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.4,
              minChildSize: 0.3,
              maxChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: child,
                  // ),
                );
              },
            ),
            Positioned(
              top: -60,
              left: 10,
              child: ButtonWidget(
                width: 50,
                bgColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_outlined,
                    color: Theme.of(context).primaryColor),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
                onTap: () {
                  context
                      .read<MapInformation>()
                      .updateCheckEndPoint(updateCheck: false);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
