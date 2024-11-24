import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/text_field_widget.dart';
import '../../../../core/widget/text_field_widget2.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../login/presentation/manager/auth_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _picker = ImagePicker();
  @override
  void initState() {
    UserData? userData = context.read<AuthProvider>().userData;
    print('userData?.phone:${userData?.phone}');
    _emailController.text = userData?.email ?? '';
    _nameController.text = userData?.name ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final editProfileCubit = context.read<AuthProvider>();

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      editProfileCubit.setImage(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.read<AuthProvider>().clearImage();

          //we need to return a future
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: AppColor.mainColor,
              onPressed: () {
                context.read<AuthProvider>().clearImage();
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text(
              'البيانات الشخصية',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
          body: Consumer<AuthProvider>(builder: (context, state, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(context),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            state.selectedImage != null
                                ? CircleAvatar(
                                    radius: 30.h,
                                    backgroundColor: Colors.white,
                                    backgroundImage: FileImage(
                                        File(state.selectedImage!.path)),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: context
                                            .read<AuthProvider>()
                                            .userData
                                            ?.image ??
                                        '',
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
                                            color: AppColor.greyColor
                                                .withOpacity(.3),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColor.mainColor,
                                        ),
                                      );
                                    }),
                            Image.asset(
                              AppImages.editImage,
                              height: 25.h,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: TextFieldWidget2(
                          hintText: 'الإسم واللقب',
                          controler: _nameController,
                          validatorTextField: (val) =>
                              ValidationTextField.phoneNumberInput(val),
                          labelText: 'الإسم واللقب',
                          keyboardType: TextInputType.text,
                          fontSize: 14.sp,
                          borderSideColor: AppColor.greyColor.withOpacity(.1),
                          fillColor: AppColor.greyColor.withOpacity(.05),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: TextFieldWidget2(
                          hintText: 'البريد الالكترونى',
                          controler: _emailController,
                          validatorTextField: (val) =>
                              ValidationTextField.emailInput(val),
                          labelText: 'البريد الالكترونى',
                          keyboardType: TextInputType.text,
                          fontSize: 14.sp,
                          borderSideColor: AppColor.greyColor.withOpacity(.1),
                          fillColor: AppColor.greyColor.withOpacity(.05),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: TextFieldWidget2(
                            hintText: 'رقم الهاتف',
                            tempTextAlign: TextAlign.left,
                            controler: TextEditingController(
                                text: state.userData?.phone ?? ''),
                            validatorTextField: (val) =>
                                ValidationTextField.emailInput(val),
                            labelText: 'رقم الهاتف',
                            onChanged: (e) {},
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            fontSize: 14.sp,
                            borderSideColor: AppColor.greyColor.withOpacity(.1),
                            fillColor: AppColor.greyColor.withOpacity(.05),
                            leftWidget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                5.pw,
                                Text(
                                  '+218',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 14),
                                ),
                                5.pw,
                                Container(
                                  height: 20.h,
                                  width: 2,
                                  decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                5.pw,
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    (state.stateOfUpdateProfile == RequestState.loading)
                        ? CupertinoActivityIndicator()
                        : ButtonWidget(
                            bgColor: Theme.of(context).primaryColor,
                            textButton: 'حفظ',
                            textStyle: Theme.of(context).textTheme.labelLarge!,
                            onTap: () {
                              print(
                                  '_emailController.text:${_emailController.text}');
                              print(
                                  '_nameController.text:${_nameController.text}');
                              context
                                  .read<AuthProvider>()
                                  .updateUserFromProfileData(
                                      email: _emailController.text,
                                      name: _nameController.text,
                                      context: context);
                            },
                          ),
                    20.ph,
                  ],
                )
              ],
            );
          }),
        ));
  }
}
