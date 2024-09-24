import 'package:flutter/material.dart';

import 'app_color.dart';

OutlineInputBorder _getInputBorderStyle(double weight, Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: color,
      width: weight,
    ),
  );
}

//regular style for text fields
OutlineInputBorder getRegularBorderStyle(
    {double weight = 1, required Color color}) {
  return _getInputBorderStyle(weight, color);
}

//regular style [For containers]
Border getRegularBorderContainerStyle(
    {double weight = 0.5, required Color color}) {
  return Border.all(width: weight, color: color);
}

//Focused style
OutlineInputBorder getFocusedBorderStyle(
    {double weight = 0.7, required Color color}) {
  return _getInputBorderStyle(weight, color);
}

//error style
OutlineInputBorder getErroredBorderStyle(
    {double weight = 1, Color color = AppColor.redColor}) {
  return _getInputBorderStyle(weight, color);
}

//fouced error style
OutlineInputBorder getFocusedErroredBorderStyle(
    {double weight = 1.3, Color color = AppColor.redColor}) {
  return _getInputBorderStyle(weight, color);
}

//No border style
OutlineInputBorder getNoBorderStyle(
    {double weight = 0.0, Color color = Colors.transparent}) {
  return _getInputBorderStyle(weight, color);
}
