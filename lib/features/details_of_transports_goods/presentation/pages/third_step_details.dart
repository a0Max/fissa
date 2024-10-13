import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/validation_text_field.dart';
import '../../../../core/widget/text_field_widget.dart';
import '../widgets/type_of_good.dart';

class ThirdStepDetails extends StatelessWidget {
  ThirdStepDetails({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ManagerOfTransportGoods>(builder: (context, state, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ph,
            Row(
              children: [
                Expanded(
                    child: FittedBox(
                  child: Text(
                    'بضاعتك محتاجة عُمّال',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 25.sp, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(child: Image.asset(AppImages.needWorkers)),
              ],
            ),
            18.ph,
            FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    _buttonOfChooseWorkers(
                      context: context,
                      title: '1',
                      keyChoose: 1,
                      bg: state.needWorkers == 1
                          ? AppColor.mainColor
                          : AppColor.lightMainColor3.withOpacity(.2),
                      textColor: state.needWorkers == 1 ? Colors.white : null,
                      boarderColor: AppColor.lightMainColor2,
                    ),
                    10.pw,
                    _buttonOfChooseWorkers(
                        context: context,
                        title: '2',
                        keyChoose: 2,
                        textColor: state.needWorkers == 2 ? Colors.white : null,
                        bg: state.needWorkers == 2
                            ? AppColor.mainColor
                            : AppColor.lightMainColor3.withOpacity(.2),
                        boarderColor: AppColor.lightMainColor2),
                    10.pw,
                    _buttonOfChooseWorkers(
                        context: context,
                        title: '+3',
                        textColor: state.needWorkers == 3 ? Colors.white : null,
                        keyChoose: 3,
                        bg: state.needWorkers == 3
                            ? AppColor.mainColor
                            : AppColor.lightMainColor3.withOpacity(.2),
                        boarderColor: AppColor.lightMainColor2),
                  ],
                ),
              ),
            ),
            10.ph,
            FittedBox(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    _buttonOfChooseWorkers(
                        context: context,
                        keyChoose: 0,
                        textColor: state.needWorkers == 0
                            ? Colors.white
                            : AppColor.yellowColor,
                        title: 'لا أريد عمّال',
                        bg: state.needWorkers == 0
                            ? AppColor.yellowColor
                            : AppColor.yellowColor.withOpacity(.2),
                        boarderColor: AppColor.yellowColor),
                  ],
                ),
              ),
            ),
            20.ph,
            FittedBox(
              child: Text(
                'ملاحظات هنا ملاحظات هنا ملاحظات هنا ملاحظات هنا',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 15.sp),
              ),
            ),
            20.ph,
            Divider(
              color: AppColor.lightGreyColor2.withOpacity(.3),
            ),
          ],
        );
      }),
    );
  }

  Widget _buttonOfChooseWorkers({
    required BuildContext context,
    required String title,
    required Color bg,
    required int keyChoose,
    Color? textColor,
    required Color boarderColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context
              .read<ManagerOfTransportGoods>()
              .updateNeedWorkers(newData: keyChoose);
        },
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bg,
              border: Border.all(color: boarderColor, width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20.sp, color: textColor),
          ),
        ),
      ),
    );
  }
}
