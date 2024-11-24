import 'package:fisaa/core/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_color.dart';
import '../border_manager.dart';

class TextFieldWidget2 extends StatefulWidget {
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
  final TextAlign? tempTextAlign;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator? validatorTextField;
  final void Function(String)? onChanged;

  const TextFieldWidget2(
      {this.rightWidget,
      this.obscureText,
      this.oldData,
      this.tempTextAlign,
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
  State<TextFieldWidget2> createState() => _TextFieldWidget2State();
}

class _TextFieldWidget2State extends State<TextFieldWidget2> {
  TextAlign _textAlign = TextAlign.right;

  void _onTextChanged(String value) {
    if (value.isNotEmpty) {
      // Check if the first character is Arabic
      final isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(value[0]);
      setState(() {
        _textAlign = isArabic ? TextAlign.right : TextAlign.left;
      });
    } else {
      setState(() {
        _textAlign = TextAlign.left;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
        ),
        10.ph,
        Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
                controller: widget.controler,
                keyboardType: widget.keyboardType,
                initialValue: widget.oldData,
                readOnly: widget.readOnly ?? false,
                validator: (val) => widget.validatorTextField!(val),
                onChanged: (val) {
                  _onTextChanged(val);
                },
                decoration: InputDecoration(
                    enabledBorder: getRegularBorderStyle(
                        color: widget.borderSideColor ?? AppColor.greyColor),
                    focusedBorder: getFocusedBorderStyle(
                        color: widget.borderSideColor ?? AppColor.greyColor),
                    errorBorder: getErroredBorderStyle(),
                    focusedErrorBorder: getErroredBorderStyle(),
                    suffixIcon: widget.rightWidget,
                    isDense: true,
                    filled: true,
                    prefixIcon: widget.leftWidget,
                    fillColor: widget.fillColor ?? Colors.white,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: widget.fontSize ?? 15.sp)),
                onTap: widget.onTap,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.fontSize ?? 15.sp,
                ),
                textAlign: widget.tempTextAlign ?? _textAlign,
                scrollPadding: EdgeInsets.zero,
                obscureText: widget.obscureText ?? false)),
      ],
    );
  }
}
