import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_color.dart';
import '../../../intro/domain/entities/support_model.dart';

class PrivacyScreen extends StatelessWidget {
  List<TermsModel>? terms;
  List<PrivacyModel>? privacy;

  PrivacyScreen({this.terms, this.privacy});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          terms != null ? 'الشروط والأحكام' : 'عن التطبيق',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: terms != null
          ? ListView(
              children: List.generate(
                  terms?.length ?? 0,
                  (index) =>
                      _dataTerms(context, terms?[index] ?? TermsModel())),
            )
          : ListView(
              children: List.generate(
                  privacy?.length ?? 0,
                  (index) =>
                      _dataPrivacy(context, privacy?[index] ?? PrivacyModel())),
            ),
    );
  }

  Widget _dataPrivacy(BuildContext context, PrivacyModel data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(23),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Text(
        data.privacy ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.lightMainColor4),
      ),
    );
  }

  Widget _dataTerms(BuildContext context, TermsModel data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(23),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Text(
        data.terms ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.lightMainColor4),
      ),
    );
  }
}
