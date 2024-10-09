import 'package:fisaa/core/app_color.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color bgColor;
  final String? textButton;
  final double? width;
  final Widget? child;
  final TextStyle textStyle;
  final void Function() onTap;

  const ButtonWidget(
      {super.key,
      required this.bgColor,
      this.textButton,
      this.width,
      this.child,
      required this.textStyle,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        width: width ?? (MediaQuery.of(context).size.width - 30),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: child ??
            Text(
              textButton ?? '',
              style: textStyle,
            ),
      ),
    );
  }
}
