import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiver/strings.dart';

class TypeOfGood extends StatelessWidget {
  final String title;
  final String? image;
  final int? goodKey;
  final int currentKey;
  final void Function()? onTap;

  const TypeOfGood(
      {super.key,
      required this.title,
      this.image,
      this.goodKey,
      this.onTap,
      required this.currentKey});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: currentKey == goodKey
                      ? AppColor.mainColor
                      : AppColor.lightGreyColor2)),
          child: Row(
            children: [
              if (isBlank(image) == false) ...{
                CachedNetworkImage(
                    imageUrl: image ?? '',
                    height: 20.h,
                    progressIndicatorBuilder: (x, b, c) {
                      return const CupertinoActivityIndicator();
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(
                        Icons.info,
                        color: Colors.red,
                      );
                    }),
                // Image.network(
                //   image ?? '',
                // ),
                10.pw,
              },
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
