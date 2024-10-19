import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:fisaa/core/vars.dart';
import 'package:fisaa/features/details_of_transports_goods/presentation/manager/manager_of_transport_goods.dart';
import 'package:fisaa/features/login/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../intro/domain/entities/get_workers_model.dart';

class ThirdStepDetails extends StatelessWidget {
  ThirdStepDetails({super.key});

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
            GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 10,
              childAspectRatio: 2.5,
              crossAxisCount: 3,
              children: List.generate(
                  state.listOfWorkers?.length ?? 0,
                  (index) => _buttonOfChooseWorkers(
                        context: context,
                        title: state.listOfWorkers?[index].count ?? '',
                        keyChoose:
                            state.listOfWorkers?[index] ?? GetWorkersModel(),
                        bg: state.listOfWorkers?[index].id ==
                                state.needWorkersObject?.id
                            ? AppColor.mainColor
                            : AppColor.lightMainColor3.withOpacity(.2),
                        textColor: state.listOfWorkers?[index].id ==
                                state.needWorkersObject?.id
                            ? Colors.white
                            : null,
                        boarderColor: AppColor.lightMainColor2,
                      )),
            ),
            10.ph,
            FittedBox(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    if (state.emptyWorker != null) ...{
                      _buttonOfChooseWorkers(
                          width: MediaQuery.of(context).size.width,
                          context: context,
                          keyChoose: state.emptyWorker ?? GetWorkersModel(),
                          textColor: state.needWorkersObject?.count == '0'
                              ? Colors.white
                              : AppColor.yellowColor,
                          title: 'لا أريد عمّال',
                          bg: state.needWorkersObject?.count == '0'
                              ? AppColor.yellowColor
                              : AppColor.yellowColor.withOpacity(.2),
                          boarderColor: AppColor.yellowColor),
                    }
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
    double? width,
    required Color bg,
    required GetWorkersModel keyChoose,
    Color? textColor,
    required Color boarderColor,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<ManagerOfTransportGoods>().updateNeedWorkers(
              newData: keyChoose,
            );
      },
      child: Container(
        height: 40.h,
        width: width,
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
    );
  }
}
