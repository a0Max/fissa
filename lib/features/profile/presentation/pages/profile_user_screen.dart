import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/login/presentation/manager/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import 'edit_profile_screen.dart';

class ProfileUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData? userData = context.select((AuthProvider n) => n.userData);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'حسابي',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: userData?.image ?? '',
                progressIndicatorBuilder: (x, b, c) {
                  return const CupertinoActivityIndicator();
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 65.h,
                    width: 65.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: imageProvider,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 65.h,
                    width: 65.h,
                    decoration: BoxDecoration(
                        color: AppColor.greyColor.withOpacity(.3),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.person,
                      color: AppColor.mainColor,
                    ),
                  );
                }),
            20.ph,
            Text(
              userData?.name ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 25.sp, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                Utils.navigateTo(EditProfileScreen(), context);
              },
              child: _itemOfProfile(
                context: context,
                title: 'تعديل الحساب',
                image: AppImages.user2,
              ),
            ),
            GestureDetector(
              child: _itemOfProfile(
                context: context,
                title: 'الشروط والاحكام',
                image: AppImages.shield,
              ),
            ),
            GestureDetector(
              child: _itemOfProfile(
                context: context,
                title: 'عن التطبيق',
                image: AppImages.aboutPhone,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<AuthProvider>().updateNotificationActive();
              },
              child: _itemOfProfile(
                context: context,
                title: 'الإشعارات',
                showSwitch: true,
                // valueOfSwitch: ,
                image: AppImages.notification,
              ),
            ),
            GestureDetector(
              child: Column(
                children: [
                  _iconInProfile(AppImages.logout),
                  Text(
                    "تسجيل الخروج",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemOfProfile(
      {required BuildContext context,
      required String title,
      bool? showSwitch,
      required String image}) {
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              10.pw,
              _iconInProfile(image, padding: 10, height: 17.h),
              10.pw,
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              if (showSwitch == true) ...{
                CupertinoSwitch(
                  activeColor: AppColor.mainColor,
                  value: context.watch<AuthProvider>().activeNotification,
                  onChanged: (bool? value) {
                    context.read<AuthProvider>().updateNotificationActive();
                  },
                )
              } else ...{
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              },
              10.pw,
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconInProfile(String image, {double? padding, double? height}) {
    return Container(
      padding: EdgeInsets.all(padding ?? 15),
      // height: 35.h,
      // width: 35.h,
      decoration: BoxDecoration(
          color: AppColor.mainColor.withOpacity(.1), shape: BoxShape.circle),
      child: Image.asset(
        image,
        height: height ?? 20.h,
      ),
    );
  }
}
