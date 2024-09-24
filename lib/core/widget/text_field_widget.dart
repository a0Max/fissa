import 'package:flutter/material.dart';
import '../../../../core/app_color.dart';
import '../border_manager.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controler;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final bool? obscureText;
  final bool? readOnly;
  final String? oldData;
  final double? fontSize;
  final double? borderRadius;
  final Color? borderSideColor;
  final Color? fillColor;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator? validatorTextField;
  final void Function(String)? onChanged;

  const TextFieldWidget(
      {this.rightWidget,
      this.obscureText,
      this.oldData,
      this.leftWidget,
      this.fillColor,
      this.readOnly,
      this.onTap,
      this.keyboardType,
      required this.labelText,
      this.fontSize,
      this.borderSideColor,
      this.onChanged,
      this.borderRadius,
      required this.hintText,
      this.controler,
      this.validatorTextField});
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
            controller: controler,
            keyboardType: keyboardType,
            initialValue: oldData,
            readOnly: readOnly ?? false,
            validator: (val) => validatorTextField!(val),
            onChanged: (val) => onChanged!(val),
            decoration: InputDecoration(
                enabledBorder: getRegularBorderStyle(
                    color: borderSideColor ?? AppColor.greyColor),
                focusedBorder: getFocusedBorderStyle(
                    color: borderSideColor ?? AppColor.greyColor),
                errorBorder: getErroredBorderStyle(),
                focusedErrorBorder: getErroredBorderStyle(),
                suffixIcon: rightWidget,
                isDense: true,
                filled: true,
                labelText: labelText,
                prefixIcon: leftWidget,
                fillColor: fillColor ?? Colors.white,
                hintText: hintText,
                labelStyle:
                    TextStyle(color: Colors.grey, fontSize: fontSize ?? 15),
                hintStyle:
                    TextStyle(color: Colors.grey, fontSize: fontSize ?? 15)),
            onTap: onTap,
            obscureText: obscureText ?? false));
  }
}
