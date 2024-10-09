import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'check_the_address.dart';
import 'make_sure_about_the_end_point.dart';

class BodyOfBottomSheet extends StatelessWidget {
  const BodyOfBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: Colors.white,
      alignment: Alignment.center,
      // height: 50.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: MakeSureAboutTheEndPoint(),
    );
  }
}
